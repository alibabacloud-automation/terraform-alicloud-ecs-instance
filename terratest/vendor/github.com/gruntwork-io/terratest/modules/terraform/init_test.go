package terraform

import (
	"io/ioutil"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/stretchr/testify/assert"
)

func TestInitBackendConfig(t *testing.T) {
	t.Parallel()

	stateDirectory, err := ioutil.TempDir("", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	remoteStateFile := filepath.Join(stateDirectory, "backend.tfstate")

	testFolder, err := files.CopyTerraformFolderToTemp("../../test/fixtures/terraform-backend", t.Name())
	if err != nil {
		t.Fatal(err)
	}

	options := &Options{
		TerraformDir: testFolder,
		BackendConfig: map[string]interface{}{
			"path": remoteStateFile,
		},
	}

	InitAndApply(t, options)

	assert.FileExists(t, remoteStateFile)
}
