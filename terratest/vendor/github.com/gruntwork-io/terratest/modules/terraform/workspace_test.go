package terraform

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/stretchr/testify/assert"
)

func TestWorkspaceNew(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-workspace", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	options := &Options{
		TerraformDir: testFolder,
	}

	out := WorkspaceSelectOrNew(t, options, "terratest")

	assert.Equal(t, "terratest", out)
}

func TestWorkspaceIllegalName(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-workspace", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	options := &Options{
		TerraformDir: testFolder,
	}

	out, err := WorkspaceSelectOrNewE(t, options, "###@@@&&&")

	assert.Error(t, err)
	assert.Equal(t, "", out, "%q should be an empty string", out)
}

func TestWorkspaceSelect(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-workspace", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	options := &Options{
		TerraformDir: testFolder,
	}

	out := WorkspaceSelectOrNew(t, options, "terratest")
	assert.Equal(t, "terratest", out)

	out = WorkspaceSelectOrNew(t, options, "default")
	assert.Equal(t, "default", out)
}

func TestWorkspaceApply(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-workspace", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	options := &Options{
		TerraformDir: testFolder,
	}

	WorkspaceSelectOrNew(t, options, "Terratest")
	out := InitAndApply(t, options)

	assert.Contains(t, out, "Hello, Terratest")
}

func TestIsExistingWorkspace(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		out      string
		name     string
		expected bool
	}{
		{"  default\n* foo\n", "default", true},
		{"* default\n  foo\n", "default", true},
		{"  foo\n* default\n", "default", true},
		{"* foo\n  default\n", "default", true},
		{"  foo\n* bar\n", "default", false},
		{"* foo\n  bar\n", "default", false},
		{"  default\n* foobar\n", "foo", false},
		{"* default\n  foobar\n", "foo", false},
		{"  default\n* foo\n", "foobar", false},
		{"* default\n  foo\n", "foobar", false},
		{"* default\n  foo\n", "foo", true},
	}

	for _, testCase := range testCases {
		actual := isExistingWorkspace(testCase.out, testCase.name)
		assert.Equal(t, testCase.expected, actual, "Out: %q, Name: %q", testCase.out, testCase.name)
	}
}

func TestNameMatchesWorkspace(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name      string
		workspace string
		expected  bool
	}{
		{"default", "  default", true},
		{"default", "* default", true},
		{"default", "", false},
		{"foo", "  foobar", false},
		{"foo", "* foobar", false},
		{"foobar", "  foo", false},
		{"foobar", "* foo", false},
		{"foo", "  foo", true},
		{"foo", "* foo", true},
	}

	for _, testCase := range testCases {
		actual := nameMatchesWorkspace(testCase.name, testCase.workspace)
		assert.Equal(t, testCase.expected, actual, "Name: %q, Workspace: %q", testCase.name, testCase.workspace)
	}
}
