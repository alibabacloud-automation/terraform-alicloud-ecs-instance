package main

import (
	"crypto/rand"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"math/big"
	"net/http"
	"os"
	"strings"
)

var urlPrefix = "https://terraform-fc-test-for-example-module.oss-ap-southeast-1.aliyuncs.com"

func main() {
	if len(os.Args)!=4{
		log.Println("[ERROR] invalid args")
		return
	}
	branch := strings.TrimSpace(os.Args[1])
	repoName := strings.TrimSpace(os.Args[2])
	ossObjectPath := strings.TrimSpace(os.Args[3])

	// get trigger url
	fcTriggerUrl := urlPrefix + "/fcUrls.json"
	response, err := http.Get(fcTriggerUrl)
	if err != nil {
		log.Println("[ERROR] get fc trigger url failed")
	}
	defer response.Body.Close()

	content, _ := io.ReadAll(response.Body)
	var data interface{}
	json.Unmarshal(content, &data)
	triggerMap := data.(map[string]interface{})

	n, _ := rand.Int(rand.Reader, big.NewInt(100))
	index := int(n.Int64()) % len(triggerMap)
	triggerUrl := triggerMap[fmt.Sprintf("%d", index)]
	fmt.Println(triggerUrl)

	// curl
	client := &http.Client{}
	req, err := http.NewRequest("GET", triggerUrl.(string),
		nil)
	if err != nil {
		panic(err)
	}
	req.Header.Add("X-Fc-Invocation-Type", "Async")

	query := req.URL.Query()
	query.Add("branch", branch)
	query.Add("repo_name", repoName)
	query.Add("oss_object_path", ossObjectPath)
	req.URL.RawQuery = query.Encode()

	if _, err := client.Do(req); err != nil {
		log.Printf("[ERROR] fail to trigger fc test, err: %s", err)
	}

}
