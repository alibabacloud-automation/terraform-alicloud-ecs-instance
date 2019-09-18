package ssh

import (
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSshAgentWithKeyPair(t *testing.T) {
	t.Parallel()

	keyPair := GenerateRSAKeyPair(t, 2048)
	sshAgent := SshAgentWithKeyPair(t, keyPair)

	// ensure that socket directory is set in environment, and it exists
	sockFile := filepath.Join(sshAgent.socketDir, "ssh_auth.sock")
	assert.FileExists(t, sockFile)

	// assert that there's 1 key in the agent
	keys, err := sshAgent.agent.List()
	assert.NoError(t, err)
	assert.Len(t, keys, 1)

	sshAgent.Stop()

	// is socketDir removed as expected?
	if _, err := os.Stat(sshAgent.socketDir); !os.IsNotExist(err) {
		assert.FailNow(t, "ssh agent failed to remove socketDir on Stop()")
	}
}

func TestSshAgentWithKeyPairs(t *testing.T) {
	t.Parallel()

	keyPair := GenerateRSAKeyPair(t, 2048)
	keyPair2 := GenerateRSAKeyPair(t, 2048)
	sshAgent := SshAgentWithKeyPairs(t, []*KeyPair{keyPair, keyPair2})
	defer sshAgent.Stop()

	keys, err := sshAgent.agent.List()
	assert.NoError(t, err)
	assert.Len(t, keys, 2)
}

func TestMultipleSshAgents(t *testing.T) {
	t.Parallel()

	keyPair := GenerateRSAKeyPair(t, 2048)
	keyPair2 := GenerateRSAKeyPair(t, 2048)

	// start a couple of agents
	sshAgent := SshAgentWithKeyPair(t, keyPair)
	sshAgent2 := SshAgentWithKeyPair(t, keyPair2)
	defer sshAgent.Stop()
	defer sshAgent2.Stop()

	// collect public keys from the agents
	keys, err := sshAgent.agent.List()
	assert.NoError(t, err)
	keys2, err := sshAgent2.agent.List()
	assert.NoError(t, err)

	// check that all keys match up to expected
	assert.NotEqual(t, keys, keys2)
	assert.Equal(t, strings.TrimSpace(keyPair.PublicKey), keys[0].String())
	assert.Equal(t, strings.TrimSpace(keyPair2.PublicKey), keys2[0].String())

}
