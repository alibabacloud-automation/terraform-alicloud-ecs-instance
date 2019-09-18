package terraform

import (
	"testing"

	"github.com/magiconair/properties/assert"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/stretchr/testify/require"
)

func TestApplyNoError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-no-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
		NoColor:      true,
	}

	out := InitAndApply(t, options)

	require.Contains(t, out, "Hello, World")

	// Check that NoColor correctly doesn't output the colour escape codes which look like [0m,[1m or [32m
	require.NotRegexp(t, `\[\d*m`, out, "Output should not contain color escape codes")
}

func TestApplyWithErrorNoRetry(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-with-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
	}

	out, err := InitAndApplyE(t, options)

	require.Error(t, err)
	require.Contains(t, out, "This is the first run, exiting with an error")
}

func TestApplyWithErrorWithRetry(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-with-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
		MaxRetries:   1,
		RetryableTerraformErrors: map[string]string{
			"This is the first run, exiting with an error": "Intentional failure in test fixture",
		},
	}

	out := InitAndApply(t, options)

	require.Contains(t, out, "This is the first run, exiting with an error")
}
func TestTgApplyAllTgError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerragruntFolderToTemp("../../test/fixtures/terragrunt/terragrunt-no-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir:    testFolder,
		TerraformBinary: "terragrunt",
	}

	out := TgApplyAll(t, options)

	require.Contains(t, out, "Hello, World")
}

func TestTgApplyAllError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerragruntFolderToTemp("../../test/fixtures/terragrunt/terragrunt-with-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir:    testFolder,
		TerraformBinary: "terragrunt",
		MaxRetries:      1,
		RetryableTerraformErrors: map[string]string{
			"This is the first run, exiting with an error": "Intentional failure in test fixture",
		},
	}

	out := TgApplyAll(t, options)

	require.Contains(t, out, "This is the first run, exiting with an error")
}

func TestTgApplyOutput(t *testing.T) {
	t.Parallel()

	options := &Options{
		TerraformDir:    "../../test/fixtures/terragrunt/terragrunt-output",
		TerraformBinary: "terragrunt",
	}

	Apply(t, options)

	strOutput := OutputRequired(t, options, "str")
	assert.Equal(t, strOutput, "str")

	listOutput := OutputList(t, options, "list")
	assert.Equal(t, listOutput, []string{"a", "b", "c"})

	mapOutput := OutputMap(t, options, "map")
	assert.Equal(t, mapOutput, map[string]string{"foo": "bar"})

	allOutputs := OutputForKeys(t, options, []string{"str", "list", "map"})
	assert.Equal(t, allOutputs, map[string]interface{}{"str": "str", "list": []interface{}{"a", "b", "c"}, "map": map[string]interface{}{"foo": "bar"}})
}
