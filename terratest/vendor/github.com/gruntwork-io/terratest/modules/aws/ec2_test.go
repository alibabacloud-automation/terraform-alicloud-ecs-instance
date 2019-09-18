package aws

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestGetEc2InstanceIdsByTag(t *testing.T) {
	t.Parallel()

	region := GetRandomStableRegion(t, nil, nil)
	ids, err := GetEc2InstanceIdsByTagE(t, region, "Name", fmt.Sprintf("nonexistent-%s", random.UniqueId()))
	require.NoError(t, err)
	assert.Equal(t, 0, len(ids))
}

func TestGetEc2InstanceIdsByFilters(t *testing.T) {
	t.Parallel()

	region := GetRandomStableRegion(t, nil, nil)
	filters := map[string][]string{
		"instance-state-name": {"running", "shutting-down"},
		"tag:Name":            {fmt.Sprintf("nonexistent-%s", random.UniqueId())},
	}

	ids, err := GetEc2InstanceIdsByFiltersE(t, region, filters)
	require.NoError(t, err)
	assert.Equal(t, 0, len(ids))
}
