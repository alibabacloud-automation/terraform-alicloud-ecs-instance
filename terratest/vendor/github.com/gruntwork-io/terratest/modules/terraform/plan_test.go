package terraform

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/stretchr/testify/require"
)

func TestInitAndPlanWithError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-with-plan-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
	}

	_, err = InitAndPlanE(t, options)
	require.Error(t, err)
}

func TestInitAndPlanWithNoError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-no-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
	}

	out, err := InitAndPlanE(t, options)
	require.NoError(t, err)
	require.Contains(t, out, "No changes. Infrastructure is up-to-date.")
}

func TestPlanWithExitCodeWithNoChanges(t *testing.T) {
	t.Parallel()
	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-no-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
	}
	exitCode := InitAndPlanWithExitCode(t, options)
	require.Equal(t, DefaultSuccessExitCode, exitCode)
}

func TestPlanWithExitCodeWithChanges(t *testing.T) {
	t.Parallel()
	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-basic-configuration", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
		Vars: map[string]interface{}{
			"cnt": 1,
		},
	}
	exitCode := InitAndPlanWithExitCode(t, options)
	require.Equal(t, TerraformPlanChangesPresentExitCode, exitCode)
}

func TestPlanWithExitCodeWithFailure(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-with-plan-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir: testFolder,
	}

	_, getExitCodeErr := InitAndPlanWithExitCodeE(t, options)
	require.Error(t, getExitCodeErr)
}

func TestTgPlanAllNoError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerragruntFolderToTemp("../../test/fixtures/terragrunt/terragrunt-multi-plan", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir:    testFolder,
		TerraformBinary: "terragrunt",
	}

	getExitCode, errExitCode := TgPlanAllExitCodeE(t, options)
	// GetExitCodeForRunCommandError was unable to determine the exit code correctly
	if errExitCode != nil {
		t.Fatal(errExitCode)
	}

	// Since PlanAllExitCodeTgE returns error codes, we want to compare against 1
	require.Equal(t, DefaultSuccessExitCode, getExitCode)
}

func TestTgPlanAllWithError(t *testing.T) {
	t.Parallel()

	testFolder, err := files.CopyTerragruntFolderToTemp("../../test/fixtures/terragrunt/terragrunt-with-plan-error", t.Name())
	require.NoError(t, err)

	options := &Options{
		TerraformDir:    testFolder,
		TerraformBinary: "terragrunt",
	}

	getExitCode, errExitCode := TgPlanAllExitCodeE(t, options)
	// GetExitCodeForRunCommandError was unable to determine the exit code correctly
	require.NoError(t, errExitCode)

	require.Equal(t, DefaultErrorExitCode, getExitCode)
}
