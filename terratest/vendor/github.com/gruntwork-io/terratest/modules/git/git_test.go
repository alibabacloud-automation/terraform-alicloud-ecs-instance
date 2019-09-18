package git

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetCurrentBranchName(t *testing.T) {
	t.Parallel()

	name := GetCurrentBranchName(t)
	assert.NotEmpty(t, name)
}
