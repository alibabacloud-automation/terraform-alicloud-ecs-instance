package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformBasicExampleNew(t *testing.T) {
	t.Parallel()
	uniqueId := random.UniqueId()
	uniqueName := fmt.Sprintf("tf-testAcc%s", uniqueId)
	instanceName := uniqueName
	instanceTags := map[string]string{
		"created_by":   "Terraform123",
		"created_from": "module-tf-alicloud-ecs-instance123",
	}
	diskName := uniqueName
	diskCategory := "cloud_ssd"
	diskSize := "20"
	diskTags := instanceTags
	systemCategory := "cloud_ssd"
	systemSize := "20"
	hostName := uniqueName
	password := "YourPassword_123"
	internetChargeType := "PayByBandwidth"
	internetMaxBandwidthOut := "20"
	instanceChargeType := "PostPaid"
	numberOfInstances :="1"
	userData := ""

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"instance_name":              instanceName,
			"instance_tags":              instanceTags,
			"disk_name":                  diskName,
			"disk_category":              diskCategory,
			"disk_size":                  diskSize,
			"disk_tags":                  diskTags,
			"system_category":            systemCategory,
			"system_size":                systemSize,
			"host_name":                  hostName,
			"password":                   password,
			"internet_charge_type":       internetChargeType,
			"internet_max_bandwidth_out": internetMaxBandwidthOut,
			"instance_charge_type":       instanceChargeType,
			"number_of_instances":        numberOfInstances,
			"user_data":                  userData,
			// We also can see how lists and maps translate between terratest and terraform.
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualInstanceName := terraform.Output(t, terraformOptions, "instance_name")
	actualInstanceTags := terraform.OutputMap(t, terraformOptions, "instance_tags")
	actualSystemCategory := terraform.Output(t, terraformOptions, "system_category")
	actualSystemSize := terraform.Output(t, terraformOptions, "system_size")
	actualHostName := terraform.Output(t, terraformOptions, "host_name")
	actualPassword := terraform.Output(t, terraformOptions, "password")
	actualInternetChargeType := terraform.Output(t, terraformOptions, "internet_charge_type")
	actualInternetMaxBandwidthOut := terraform.Output(t, terraformOptions, "internet_max_bandwidth_out")
	actualInstanceChargeType := terraform.Output(t, terraformOptions, "instance_charge_type")
	actualNumberOfInstances:=terraform.Output(t, terraformOptions, "number_of_instances")
	actualUserData := terraform.Output(t, terraformOptions, "user_data")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, instanceName, actualInstanceName)
	assert.Equal(t, instanceTags, actualInstanceTags)
	assert.Equal(t, systemCategory, actualSystemCategory)
	assert.Equal(t, systemSize, actualSystemSize)
	assert.Equal(t, hostName, actualHostName)
	assert.Equal(t, password, actualPassword)
	assert.Equal(t, internetChargeType, actualInternetChargeType)
	assert.Equal(t, internetMaxBandwidthOut, actualInternetMaxBandwidthOut)
	assert.Equal(t, instanceChargeType, actualInstanceChargeType)
	assert.Equal(t, numberOfInstances, actualNumberOfInstances)
	assert.Equal(t, userData, actualUserData)

}
