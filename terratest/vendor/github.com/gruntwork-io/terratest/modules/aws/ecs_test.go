package aws

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestEcsCluster(t *testing.T) {
	t.Parallel()

	region := GetRandomStableRegion(t, nil, nil)
	c1, err := CreateEcsClusterE(t, region, "terratest")
	defer DeleteEcsCluster(t, region, c1)

	assert.Nil(t, err)
	assert.Equal(t, "terratest", *c1.ClusterName)

	c2, err := GetEcsClusterE(t, region, *c1.ClusterName)

	assert.Nil(t, err)
	assert.Equal(t, "terratest", *c2.ClusterName)
}
