package shell

import (
	"fmt"
	"regexp"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/gruntwork-io/terratest/modules/random"
)

func TestRunCommandAndGetOutput(t *testing.T) {
	t.Parallel()

	text := "Hello, World"
	cmd := Command{
		Command: "echo",
		Args:    []string{text},
	}

	out := RunCommandAndGetOutput(t, cmd)
	assert.Equal(t, text, strings.TrimSpace(out))
}

func TestRunCommandAndGetOutputOrder(t *testing.T) {
	t.Parallel()

	stderrText := "Hello, Error"
	stdoutText := "Hello, World"
	expectedText := "Hello, Error\nHello, World\nHello, Error\nHello, World\nHello, Error\nHello, Error"
	bashCode := fmt.Sprintf(`
echo_stderr(){
	(>&2 echo "%s")
	# Add sleep to stabilize the test
	sleep .01s
}
echo_stdout(){
	echo "%s"
	# Add sleep to stabilize the test
	sleep .01s
}
echo_stderr
echo_stdout
echo_stderr
echo_stdout
echo_stderr
echo_stderr
`,
		stderrText,
		stdoutText,
	)
	cmd := Command{
		Command: "bash",
		Args:    []string{"-c", bashCode},
	}

	out := RunCommandAndGetOutput(t, cmd)
	assert.Equal(t, strings.TrimSpace(out), expectedText)
}

func TestRunCommandAndGetOutputConcurrency(t *testing.T) {
	t.Parallel()

	uniqueStderr := random.UniqueId()
	uniqueStdout := random.UniqueId()

	bashCode := fmt.Sprintf(`
echo_stderr(){
	sleep .0$[ ( $RANDOM %% 10 ) + 1 ]s
	(>&2 echo "%s")
}
echo_stdout(){
	sleep .0$[ ( $RANDOM %% 10 ) + 1 ]s
	echo "%s"
}
for i in {1..500}
do
	echo_stderr &
	echo_stdout &
done
wait
`,
		uniqueStderr,
		uniqueStdout,
	)
	cmd := Command{
		Command: "bash",
		Args:    []string{"-c", bashCode},
	}

	out := RunCommandAndGetOutput(t, cmd)
	stdoutReg := regexp.MustCompile(uniqueStdout)
	stderrReg := regexp.MustCompile(uniqueStderr)
	assert.Equal(t, len(stdoutReg.FindAllString(out, -1)), 500)
	assert.Equal(t, len(stderrReg.FindAllString(out, -1)), 500)
}
