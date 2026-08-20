package main

import (
	"log"
	"net/http"
	"os"
	"strings"
)

var fcTriggerURL = "https://module-ci-terrafoodule-ci-uyjvvfbaqr.ap-southeast-1.fcapp.run"

func main() {
	if len(os.Args) != 4 {
		log.Println("[ERROR] invalid args")
		return
	}
	branch := strings.TrimSpace(os.Args[1])
	repoName := strings.TrimSpace(os.Args[2])
	ossObjectPath := strings.TrimSpace(os.Args[3])

	client := &http.Client{}
	req, err := http.NewRequest("GET", fcTriggerURL, nil)
	if err != nil {
		log.Printf("[ERROR] create FC trigger request failed: %s", err)
		return
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
