package files

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

const copyFolderContentsFixtureRoot = "../../test/fixtures/copy-folder-contents"

func TestFileExists(t *testing.T) {
	t.Parallel()

	currentFile, err := filepath.Abs(os.Args[0])
	require.NoError(t, err)

	assert.True(t, FileExists(currentFile))
	assert.False(t, FileExists("/not/a/real/path"))
}

func TestCopyFolderContents(t *testing.T) {
	t.Parallel()

	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "original")
	expectedDir := filepath.Join(copyFolderContentsFixtureRoot, "full-copy")
	tmpDir, err := ioutil.TempDir("", "TestCopyFolderContents")
	require.NoError(t, err)

	err = CopyFolderContents(originalDir, tmpDir)
	require.NoError(t, err)

	requireDirectoriesEqual(t, expectedDir, tmpDir)
}

func TestCopyFolderContentsWithHiddenFilesFilter(t *testing.T) {
	t.Parallel()

	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "original")
	expectedDir := filepath.Join(copyFolderContentsFixtureRoot, "no-hidden-files")
	tmpDir, err := ioutil.TempDir("", "TestCopyFolderContentsWithFilter")
	require.NoError(t, err)

	err = CopyFolderContentsWithFilter(originalDir, tmpDir, func(path string) bool {
		return !PathContainsHiddenFileOrFolder(path)
	})
	require.NoError(t, err)

	requireDirectoriesEqual(t, expectedDir, tmpDir)
}

// Test copying a folder that contains symlinks
func TestCopyFolderContentsWithSymLinks(t *testing.T) {
	t.Parallel()

	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "symlinks")
	expectedDir := filepath.Join(copyFolderContentsFixtureRoot, "symlinks")
	tmpDir, err := ioutil.TempDir("", "TestCopyFolderContentsWithFilter")
	require.NoError(t, err)

	err = CopyFolderContentsWithFilter(originalDir, tmpDir, func(path string) bool {
		return !PathContainsHiddenFileOrFolder(path)
	})
	require.NoError(t, err)

	requireDirectoriesEqual(t, expectedDir, tmpDir)
}

// Test copying a folder that contains symlinks that point to a non-existent file
func TestCopyFolderContentsWithBrokenSymLinks(t *testing.T) {
	t.Parallel()

	// Creating broken symlink
	pathToFile := filepath.Join(copyFolderContentsFixtureRoot, "symlinks-broken/nonexistent-folder/bar.txt")
	pathToSymlink := filepath.Join(copyFolderContentsFixtureRoot, "symlinks-broken/bar.txt")
	defer func() {
		if err := os.Remove(pathToSymlink); err != nil {
			t.Fatal(fmt.Errorf("Failed to remove link: %+v", err))
		}
	}()
	if err := os.Symlink(pathToFile, pathToSymlink); err != nil {
		t.Fatal(fmt.Errorf("Failed to create broken link for test: %+v", err))
	}

	// Test copying folder
	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "symlinks-broken")
	tmpDir, err := ioutil.TempDir("", "TestCopyFolderContentsWithFilter")
	require.NoError(t, err)

	err = CopyFolderContentsWithFilter(originalDir, tmpDir, func(path string) bool {
		return !PathContainsHiddenFileOrFolder(path)
	})
	require.NoError(t, err)

	// This requireDirectoriesEqual command uses GNU diff under the hood, but unfortunately we cannot instruct diff to
	// compare symlinks in two directories without attempting to dereference any symlinks until diff version 3.3.0.
	// Because many environments are still using diff < 3.3.0, we disregard this test for now.
	// Per https://unix.stackexchange.com/a/119406/129208
	//requireDirectoriesEqual(t, expectedDir, tmpDir)
	fmt.Println("Test completed without error, however due to a limitation in GNU diff < 3.3.0, directories have not been compared for equivalency.")
}

func TestCopyTerraformFolderToTemp(t *testing.T) {
	t.Parallel()

	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "original")
	expectedDir := filepath.Join(copyFolderContentsFixtureRoot, "no-hidden-files-no-terraform-files")

	tmpDir, err := CopyTerraformFolderToTemp(originalDir, "TestCopyTerraformFolderToTemp")
	require.NoError(t, err)

	requireDirectoriesEqual(t, expectedDir, tmpDir)
}

func TestCopyTerragruntFolderToTemp(t *testing.T) {
	t.Parallel()

	originalDir := filepath.Join(copyFolderContentsFixtureRoot, "terragrunt-files")
	expectedDir := filepath.Join(copyFolderContentsFixtureRoot, "no-state-files")

	tmpDir, err := CopyTerragruntFolderToTemp(originalDir, t.Name())
	require.NoError(t, err)

	requireDirectoriesEqual(t, expectedDir, tmpDir)
}

// Diffing two directories to ensure they have the exact same files, contents, etc and showing exactly what's different
// takes a lot of code. Why waste time on that when this functionality is already nicely implemented in the Unix/Linux
// "diff" command? We shell out to that command at test time.
func requireDirectoriesEqual(t *testing.T, folderWithExpectedContents string, folderWithActualContents string) {
	cmd := exec.Command("diff", "-r", "-u", folderWithExpectedContents, folderWithActualContents)

	bytes, err := cmd.Output()
	output := string(bytes)

	require.NoError(t, err, "diff command exited with an error. This likely means the contents of %s and %s are different. Here is the output of the diff command:\n%s", folderWithExpectedContents, folderWithActualContents, output)
}
