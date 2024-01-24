package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

var urlPrefix = "https://terraform-fc-test-for-example-module.oss-ap-southeast-1.aliyuncs.com"

func main() {
	ossObjectPath := strings.TrimSpace(os.Args[1])
	log.Println("run log path:", ossObjectPath)
	runLogFileName := "terraform.run.log"
	runResultFileName := "terraform.run.result.log"
	runLogUrl := urlPrefix + "/" + ossObjectPath + "/" + runLogFileName
	runResultUrl := urlPrefix + "/" + ossObjectPath + "/" + runResultFileName
	lastLineNum := 0
	deadline := time.Now().Add(time.Duration(24) * time.Hour)
	finish := false
	exitCode := 0
	log.Println(runLogUrl)
	errResultMessage := ""
	for !time.Now().After(deadline) {
		runLogResponse, err := http.Get(runLogUrl)
		if err != nil || runLogResponse.StatusCode != 200 {
			log.Println("waiting for job running...")
			time.Sleep(5 * time.Second)
			continue
		}
		defer runLogResponse.Body.Close()

		s, er := io.ReadAll(runLogResponse.Body)
		if er != nil && fmt.Sprint(er) != "EOF" {
			log.Println("[ERROR] reading run log response failed:", err)
		}
		lineNum := len(s)
		if runLogResponse.StatusCode == 200 {
			if lineNum > lastLineNum {
				fmt.Printf("%s", s[lastLineNum:lineNum])
				lastLineNum = lineNum
			}
		}
		if finish {
			log.Println("run log path:", ossObjectPath)
			log.Println("run log url:", runLogUrl)
			if strings.Contains(ossObjectPath, "weekly") {
				updateTestRecord(ossObjectPath)
				exitCode = 0
			}
			if errResultMessage != "" {
				log.Println("[ERROR] run result:", errResultMessage)
			}
			os.Exit(exitCode)
		}
		runResultResponse, err := http.Get(runResultUrl)
		if err != nil || runResultResponse.StatusCode != 200 {
			time.Sleep(5 * time.Second)
			continue
		}
		defer runResultResponse.Body.Close()
		runResultContent := make([]byte, 100000)
		_, err = runResultResponse.Body.Read(runResultContent)
		if err != nil && fmt.Sprint(err) != "EOF" {
			log.Println("[ERROR] reading run result response failed:", err)
		}
		finish = true
		if !strings.HasPrefix(string(runResultContent), "PASS") {
			errResultMessage = string(runResultContent)
			exitCode = 1
		}
	}
	log.Println("[ERROR] Timeout: waiting for job finished timeout after 24 hours.")
}

func updateTestRecord(ossObjectPath string) {
	currentTestRecordFileName := "TestRecord.md"
	currentTestRecordFileUrl := urlPrefix + "/" + ossObjectPath + "/" + currentTestRecordFileName
	response, err := http.Get(currentTestRecordFileUrl)
	if err != nil {
		log.Println("[ERROR] failed to get test record from oss")
		return
	}
	defer response.Body.Close()
	data, _ := io.ReadAll(response.Body)
	if response.StatusCode != 200 || len(data) == 0 {
		return
	}
	currentTestRecord := string(data) + "\n"

	testRecordFileName := "TestRecord.md"
	var testRecordFile *os.File
	oldTestRecord := ""
	if _, err := os.Stat(testRecordFileName); os.IsNotExist(err) {
		testRecordFile, err = os.Create(testRecordFileName)
		if err != nil {
			log.Println("[ERROR] failed to create test record file")
		}
	} else {
		data, err := os.ReadFile(testRecordFileName)
		if err != nil {
			log.Println("[ERROR] failed to read test record file")
			return
		}
		oldTestRecord = string(data)

		testRecordFile, err = os.OpenFile(testRecordFileName, os.O_TRUNC|os.O_RDWR, 0666)
		if err != nil {
			log.Println("[ERROR] failed to open test record file")
		}
	}
	defer testRecordFile.Close()

	currentTestRecord += oldTestRecord
	testRecordFile.WriteString(currentTestRecord)
}
