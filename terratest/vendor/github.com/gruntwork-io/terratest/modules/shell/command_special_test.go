// +build special

package shell

import (
	"bytes"
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRunCommandWithHugeLineOutput(t *testing.T) {
	t.Parallel()

	// generate a ~100KB line
	bashCode := fmt.Sprintf(`
for i in {0..35000}
do
  echo -n foo
done
echo
`)

	cmdDefault := Command{
		Command: "bash",
		Args:    []string{"-c", bashCode},
	}

	_, err := RunCommandAndGetOutputE(t, cmdDefault)
	assert.Error(t, err)

	cmdExtended := Command{
		Command:           "bash",
		Args:              []string{"-c", bashCode},
		OutputMaxLineSize: 128 * 1024,
	}

	out, err := RunCommandAndGetOutputE(t, cmdExtended)
	assert.NoError(t, err)

	var buffer bytes.Buffer
	for i := 0; i <= 35000; i++ {
		buffer.WriteString("foo")
	}

	assert.Equal(t, out, buffer.String())
}
