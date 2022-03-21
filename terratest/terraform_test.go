package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/complete using Terratest.
// Make sure you have the dep binary, https://github.com/golang/dep
// Run 'dep ensure' before run test cases.

func TestTerraformBasicExampleNew(t *testing.T) {
	t.Parallel()
	uniqueId := random.UniqueId()
	uniqueName := fmt.Sprintf("tf-testAcc%s", uniqueId)
	instanceName := uniqueName
	instanceTags := map[string]string{
		"created_by":   "Terraform123",
		"created_from": "module-tf-alicloud-ecs-instance123",
	}
	hostName := uniqueName
	password := "YourPassword_123"
	internetChargeType := "PayByBandwidth"
	internetMaxBandwidthOut := "20"
	associatePublicIpAddress := "true"
	instanceChargeType := "PostPaid"
	userData := ""
	systemDiskCategory := "cloud_efficiency"
	systemDiskSize := "40"
	dryRun := "false"
	spotStrategy := "NoSpot"
	spotPriceLimit := "0"
	deletionProtection := "false"
	forceDelete := "false"
	securityEnhancementStrategy := "Active"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./basic/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"instance_name":                 instanceName,
			"tags":                          instanceTags,
			"host_name":                     hostName,
			"password":                      password,
			"internet_charge_type":          internetChargeType,
			"internet_max_bandwidth_out":    internetMaxBandwidthOut,
			"associate_public_ip_address":   associatePublicIpAddress,
			"instance_charge_type":          instanceChargeType,
			"user_data":                     userData,
			"system_disk_category":          systemDiskCategory,
			"system_disk_size":              systemDiskSize,
			"dry_run":                       dryRun,
			"spot_strategy":                 spotStrategy,
			"spot_price_limit":              spotPriceLimit,
			"deletion_protection":           deletionProtection,
			"force_delete":                  forceDelete,
			"security_enhancement_strategy": securityEnhancementStrategy,

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
	actualInstanceTags := terraform.OutputMap(t, terraformOptions, "this_instance_tags")
	delete(actualInstanceTags, "Name")
	actualInternetChargeType := terraform.Output(t, terraformOptions, "this_internet_charge_type")
	actualInternetMaxBandwidthOut := terraform.Output(t, terraformOptions, "this_internet_max_bandwidth_out")
	actualInstanceChargeType := terraform.Output(t, terraformOptions, "this_instance_charge_type")
	actualUserData := terraform.Output(t, terraformOptions, "this_user_data")
	actualSystemDiskCategory := terraform.Output(t, terraformOptions, "this_system_category")
	actualSystemDiskSize := terraform.Output(t, terraformOptions, "this_system_size")
	actualSpotStrategy := terraform.Output(t, terraformOptions, "this_spot_strategy")
	actualSpotPriceLimit := terraform.Output(t, terraformOptions, "this_spot_price_limit")
	actualDeletionProtection := terraform.Output(t, terraformOptions, "this_deletion_protection")
	actualSecurityEnhancementStrategy := terraform.Output(t, terraformOptions, "this_security_enhancement_strategy")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, instanceTags, actualInstanceTags)
	assert.Equal(t, internetChargeType, actualInternetChargeType)
	assert.Equal(t, internetMaxBandwidthOut, actualInternetMaxBandwidthOut)
	assert.Equal(t, instanceChargeType, actualInstanceChargeType)
	assert.Equal(t, userData, actualUserData)
	assert.Equal(t, systemDiskCategory, actualSystemDiskCategory)
	assert.Equal(t, systemDiskSize, actualSystemDiskSize)
	assert.Equal(t, spotStrategy, actualSpotStrategy)
	assert.Equal(t, spotPriceLimit, actualSpotPriceLimit)
	assert.Equal(t, deletionProtection, actualDeletionProtection)
	assert.Equal(t, securityEnhancementStrategy, actualSecurityEnhancementStrategy)
}
