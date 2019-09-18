package test

import (
	"encoding/json"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

// The tests in this folder are not example usage of Terratest. Instead, this is a regression test to ensure the
// formatting rules work with an actual Terraform call when using more complex structures.

func TestTerraformFormatNestedOneLevelList(t *testing.T) {
	t.Parallel()

	testList := [][]string{
		[]string{random.UniqueId()},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_list"] = testList

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_list")
	actualExampleList := outputMap["value"]
	AssertEqualJson(t, actualExampleList, testList)
}

func TestTerraformFormatNestedTwoLevelList(t *testing.T) {
	t.Parallel()

	testList := [][][]string{
		[][]string{[]string{random.UniqueId()}},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_list"] = testList

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_list")
	actualExampleList := outputMap["value"]
	AssertEqualJson(t, actualExampleList, testList)
}

func TestTerraformFormatNestedMultipleItems(t *testing.T) {
	t.Parallel()

	testList := [][]string{
		[]string{random.UniqueId(), random.UniqueId()},
		[]string{random.UniqueId(), random.UniqueId(), random.UniqueId()},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_list"] = testList

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_list")
	actualExampleList := outputMap["value"]
	AssertEqualJson(t, actualExampleList, testList)
}

func TestTerraformFormatNestedOneLevelMap(t *testing.T) {
	t.Parallel()

	testMap := map[string]map[string]string{
		"test": map[string]string{
			"foo": random.UniqueId(),
		},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_map"] = testMap

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_map")
	actualExampleMap := outputMap["value"]
	AssertEqualJson(t, actualExampleMap, testMap)
}

func TestTerraformFormatNestedTwoLevelMap(t *testing.T) {
	t.Parallel()

	testMap := map[string]map[string]map[string]string{
		"test": map[string]map[string]string{
			"foo": map[string]string{
				"bar": random.UniqueId(),
			},
		},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_map"] = testMap

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_map")
	actualExampleMap := outputMap["value"]
	AssertEqualJson(t, actualExampleMap, testMap)
}

func TestTerraformFormatNestedMultipleItemsMap(t *testing.T) {
	t.Parallel()

	testMap := map[string]map[string]string{
		"test": map[string]string{
			"foo": random.UniqueId(),
			"bar": random.UniqueId(),
		},
		"other": map[string]string{
			"baz": random.UniqueId(),
			"boo": random.UniqueId(),
		},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_map"] = testMap

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_map")
	actualExampleMap := outputMap["value"]
	AssertEqualJson(t, actualExampleMap, testMap)
}

func TestTerraformFormatNestedListMap(t *testing.T) {
	t.Parallel()

	testMap := map[string][]string{
		"test": []string{random.UniqueId(), random.UniqueId()},
	}

	options := GetTerraformOptionsForFormatTests(t)
	options.Vars["example_map"] = testMap

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)
	outputMap := OutputJsonMap(t, options, "example_map")
	actualExampleMap := outputMap["value"]
	AssertEqualJson(t, actualExampleMap, testMap)
}

func GetTerraformOptionsForFormatTests(t *testing.T) *terraform.Options {
	exampleFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/terraform-basic-example")

	terraformOptions := &terraform.Options{
		TerraformDir: exampleFolder,
		Vars:         map[string]interface{}{},
		NoColor:      true,
	}
	return terraformOptions
}

// To avoid conversion errors with nested data structures, we work directly off the json output when comparing the data.
// This is because both OutputList and OutputMap assume the data is single level deep.
func OutputJsonMap(t *testing.T, options *terraform.Options, key string) map[string]interface{} {
	out, err := terraform.RunTerraformCommandE(t, options, "output", "-no-color", "-json", key)
	require.NoError(t, err)

	outputMap := map[string]interface{}{}
	require.NoError(t, json.Unmarshal([]byte(out), &outputMap))
	return outputMap
}

// The value of the output nested in the outputMap returned by OutputJsonMap uses the interface{} type for nested
// structures. This can't be compared to actual types like [][]string{}, so we instead compare the json versions.
func AssertEqualJson(t *testing.T, actual interface{}, expected interface{}) {
	actualJson, err := json.Marshal(actual)
	require.NoError(t, err)
	expectedJson, err := json.Marshal(expected)
	require.NoError(t, err)
	assert.Equal(t, actualJson, expectedJson)
}
