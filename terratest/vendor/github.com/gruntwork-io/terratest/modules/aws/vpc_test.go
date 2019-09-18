package aws

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetDefaultVpc(t *testing.T) {
	t.Parallel()

	region := GetRandomStableRegion(t, nil, nil)
	vpc := GetDefaultVpc(t, region)

	assert.NotEmpty(t, vpc.Name)
	assert.True(t, len(vpc.Subnets) > 0)
	assert.Regexp(t, "^vpc-[[:alnum:]]+$", vpc.Id)
}

func TestGetFirstTwoOctets(t *testing.T) {
	t.Parallel()

	firstTwo := GetFirstTwoOctets("10.100.0.0/28")
	if firstTwo != "10.100" {
		t.Errorf("Received: %s, Expected: 10.100", firstTwo)
	}
}
