variable "region" {
  description = "(Deprecated from version 2.8.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 2.8.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}

variable "shared_credentials_file" {
  description = "(Deprecated from version 2.8.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 2.8.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "internet_max_bandwidth_in" {
  description = "(Deprecated from version v1.121.2) The maximum internet in bandwidth of instance. The attribute is invalid and no any affect for the instance. So it has been deprecated from version v1.121.2."
  type        = number
  default     = 100
}

# Ecs instance variables
variable "number_of_instances" {
  description = "The number of instances to be created."
  type        = number
  default     = 1
}

variable "image_id" {
  description = "The image id used to launch one or more ecs instances."
  type        = string
  default     = ""
}

variable "image_ids" {
  description = "A list of ecs image IDs to launch one or more ecs instances."
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  type        = string
  default     = ""
}

variable "credit_specification" {
  description = "Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'."
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "A list of security group ids to associate with."
  type        = list(string)
  default     = []
}

variable "vswitch_id" {
  description = "The virtual switch ID to launch in VPC."
  type        = string
  default     = ""
}

variable "vswitch_ids" {
  description = "A list of virtual switch IDs to launch in."
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name to be used on all resources as prefix. Default to 'TF-Module-ECS-Instance'. The final default name would be TF-Module-ECS-Instance001, TF-Module-ECS-Instance002 and so on."
  type        = string
  default     = ""
}

variable "use_num_suffix" {
  description = "Always append numerical suffix(like 001, 002 and so on) to instance name and host name, even if number_of_instances is 1."
  type        = bool
  default     = false
}

variable "host_name" {
  description = "Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of all instances."
  type        = string
  default     = "An ECS instance came from terraform-alicloud-modules/ecs-instance"
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  type        = string
  default     = "PayByTraffic"
}

variable "password" {
  description = "The password of instance."
  type        = string
  default     = ""
}

variable "kms_encrypted_password" {
  description = "An KMS encrypts password used to an instance. It is conflicted with 'password'."
  type        = string
  default     = ""
}

variable "kms_encryption_context" {
  description = "An KMS encryption context used to decrypt 'kms_encrypted_password' before creating or updating an instance with 'kms_encrypted_password'."
  type        = map(string)
  default     = {}
}

variable "system_disk_category" {
  description = "The system disk category used to launch one or more ecs instances."
  type        = string
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "system_disk_name" {
  description = "The name of the system disk. The name must be 2 to 128 characters in length and can contain letters, digits, periods (.), colons (:), underscores (_), and hyphens (-). It must start with a letter and cannot start with http:// or https://."
  type        = string
  default     = ""
}

variable "system_disk_description" {
  description = "The description of the system disk. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
  type        = string
  default     = ""
}

variable "system_disk_performance_level" {
  description = "The performance level of the ESSD used as the system disk, Valid values: `PL0`, `PL1`, `PL2`, `PL3`, Default to `PL1`."
  type        = string
  default     = ""
}

variable "system_disk_storage_cluster_id" {
  description = "The ID of the dedicated block storage cluster. If you want to use disks in a dedicated block storage cluster as system disks when you create instances, you must specify this parameter."
  type        = string
  default     = ""
}

variable "system_disk_encrypted" {
  description = "Specifies whether to encrypt the system disk. Valid values: `true`,`false`. Default value: `false`."
  type        = bool
  default     = false
}

variable "system_disk_kms_key_id" {
  description = "The ID of the Key Management Service (KMS) key to be used for the system disk."
  type        = string
  default     = ""
}

variable "system_disk_encrypt_algorithm" {
  description = "The algorithm to be used to encrypt the system disk. Valid values are `aes-256`, `sm4-128`. Default value is `aes-256`."
  type        = string
  default     = ""
}

variable "system_disk_auto_snapshot_policy_id" {
  description = "The ID of the automatic snapshot policy applied to the system disk."
  type        = string
  default     = ""
}

variable "data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance."
  type        = list(map(string))
  default     = []
}

variable "private_ip" {
  description = "Configure Instance private IP address."
  type        = string
  default     = ""
}

variable "private_ips" {
  description = "A list to configure Instance private IP address"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 0
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "subscription" {
  description = "A mapping of fields for Prepaid ECS instances created. The attributes supported are `period`, `period_unit`, `renewal_status`, `auto_renew_period`, `include_data_disks`. The attribute `period` is valid and required when `instance_charge_type` is `PrePaid`."
  type        = map(string)
  default = {
    period             = 1
    period_unit        = "Month"
    renewal_status     = "Normal"
    auto_renew_period  = 1
    include_data_disks = true
  }
}

variable "dry_run" {
  description = "Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation. Default to false."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "User data to pass to instance on boot."
  type        = string
  default     = ""
}

variable "role_name" {
  description = "Instance RAM role name. The name is provided and maintained by RAM. You can use 'alicloud_ram_role' to create a new one."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The name of SSH key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid."
  type        = string
  default     = ""
}

variable "spot_strategy" {
  description = "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter 'instance_charge_type' is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance."
  type        = string
  default     = "NoSpot"
}

variable "spot_price_limit" {
  description = "The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'. Three decimals is allowed at most."
  type        = number
  default     = 0
}

variable "deletion_protection" {
  description = "Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection."
  type        = bool
  default     = false
}

variable "force_delete" {
  description = "If it is true, the 'PrePaid' instance will be change to 'PostPaid' and then deleted forcibly. However, because of changing instance charge type has CPU core count quota limitation, so strongly recommand that 'Don't modify instance charge type frequentlly in one month'."
  type        = bool
  default     = false
}

variable "security_enhancement_strategy" {
  description = "The security enhancement strategy."
  type        = string
  default     = "Active"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}

# Depreceted parameters
variable "instance_name" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'name' instead."
  type        = string
  default     = ""
}

variable "group_ids" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'security_group_ids' instead."
  type        = list(string)
  default     = []
}

variable "system_category" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'system_disk_category' instead."
  type        = string
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'system_disk_size' replaces it."
  type        = number
  default     = 40
}

variable "disk_name" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' 'name' instead."
  type        = string
  default     = ""
}

variable "disk_category" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' 'category' instead."
  type        = string
  default     = "cloud_efficiency"
}

variable "disk_size" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' 'size' instead."
  type        = number
  default     = 40
}

variable "disk_tags" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'volume_tags' instead."
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'tags' replaces it."
  type        = map(string)
  default     = {}
}

variable "number_of_disks" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' instead."
  type        = number
  default     = 0
}

variable "operator_type" {
  description = "The operation type. It is valid when `instance_charge_type` is `PrePaid`. Default value: upgrade. Valid values: `upgrade`, `downgrade`. NOTE: When the new instance type specified by the instance_type parameter has lower specifications than the current instance type, you must set `operator_type` to `downgrade`."
  type        = string
  default     = "upgrade"
}

variable "status" {
  description = "The instance status. Valid values: `Running`, `Stopped`. You can control the instance start and stop through this parameter. Default to Running."
  type        = string
  default     = "Running"
}

variable "hpc_cluster_id" {
  description = "The ID of the Elastic High Performance Computing (E-HPC) cluster to which to assign the instance."
  type        = string
  default     = null
}

variable "network_interface_ids" {
  description = "The list of network interfaces created with instances. When creating multiple ecs instances, leave the corresponding parameter set to \"\" for instances that do not need ENI."
  type        = list(string)
  default     = []
}

variable "auto_release_time" {
  description = "The automatic release time of the `PostPaid` instance. "
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "A list of Secondary private IP addresses which is selected from within the CIDR block of the VSwitch. This parameter is conflict with 'secondary_private_ip_address_count'. "
  type        = list(string)
  default     = null
}

variable "secondary_private_ip_address_count" {
  description = "The number of private IP addresses to be automatically assigned from within the CIDR block of the vswitch. This parameter is conflict with 'secondary_private_ips'."
  type        = number
  default     = null
}

variable "deployment_set_id" {
  description = "The ID of the deployment set to which to deploy the instance."
  type        = string
  default     = null
}

variable "stopped_mode" {
  description = "The stop mode of the pay-as-you-go instance. Valid values: `StopCharging`,`KeepCharging`, `Not-applicable`."
  type        = string
  default     = null
}

variable "maintenance_time" {
  description = "The time of maintenance."
  type        = list(map(string))
  default     = []
}

variable "maintenance_action" {
  description = "The maintenance action. Valid values: `Stop`, `AutoRecover` and `AutoRedeploy`."
  type        = string
  default     = null
}

variable "maintenance_notify" {
  description = "Specifies whether to send an event notification before instance shutdown. Valid values: `true`, `false`. Default value: `false`."
  type        = bool
  default     = null
}

variable "spot_duration" {
  description = "The retention time of the preemptive instance in hours. Valid values: `0`, `1`, `2`, `3`, `4`, `5`, `6`. Retention duration 2~6 is under invitation test, please submit a work order if you need to open. If the value is `0`, the mode is no protection period. Default value is `1`."
  type        = number
  default     = null
}

variable "http_tokens" {
  description = "Specifies whether to forcefully use the security-enhanced mode (IMDSv2) to access instance metadata. Default value: optional."
  type        = string
  default     = null
}

variable "http_endpoint" {
  description = "Specifies whether to enable the access channel for instance metadata. Valid values: `enabled`, `disabled`. Default value: `enabled`."
  type        = string
  default     = null
}

variable "http_put_response_hop_limit" {
  description = "The HTTP PUT response hop limit for accessing instance metadata. Valid values: 1 to 64. Default value: 1."
  type        = number
  default     = null
}

variable "ipv6_address_count" {
  description = "The number of IPv6 addresses to randomly generate for the primary ENI. Valid values: 1 to 10. This parameter is conflict with 'ipv6_addresses'."
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "A list of IPv6 address to be assigned to the primary ENI. Support up to 10. This parameter is conflict with 'ipv6_address_count'."
  type        = list(string)
  default     = null
}

variable "dedicated_host_id" {
  description = "The ID of the dedicated host on which to create the instance. If you set the DedicatedHostId parameter, the `spot_strategy` and `spot_price_limit` parameters cannot be set. This is because preemptible instances cannot be created on dedicated hosts."
  type        = string
  default     = null
}

variable "launch_template_name" {
  description = "The name of the launch template."
  type        = string
  default     = null
}

variable "launch_template_id" {
  description = "The ID of the launch template."
  type        = string
  default     = null
}

variable "launch_template_version" {
  description = "The version of the launch template."
  type        = string
  default     = null
}
