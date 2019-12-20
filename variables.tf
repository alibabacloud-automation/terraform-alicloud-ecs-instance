variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

variable "filter_with_name_regex" {
  description = "A default filter applied to retrieve existing vswitches, security groups, and ecs instances by name regex."
  default     = ""
}

variable "filter_with_tags" {
  description = "A default filter applied to retrieve existing vswitches, security groups, and ecs instances by tags."
  type        = map(string)
  default     = {}
}

variable "filter_with_resource_group_id" {
  description = "A default filter applied to retrieve existing vswitches, security groups, and ecs instances by resource group id."
  default     = ""
}

# Images data source variables
variable "availability_zone" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the zone id of vswitch replaces it."
  default     = ""
}

variable "number_format" {
  description = "(Deprecated) It has been deprecated from version 0.1.0. "
  default     = "%02d"
}

variable "most_recent" {
  description = "If more than one result are returned, select the most recent one."
  default     = true
}

variable "owners" {
  description = "Filter results by a specific image owner. Valid items are `system`, `self`, `others`, `marketplace`."
  default     = "system"
}

variable "image_name_regex" {
  description = "A regex string to filter resulting images by name. "
  default     = "^ubuntu_18.*_64"
}

# Instance types data source variables

variable "cpu_core_count" {
  description = "Filter the results to a specific number of cpu cores."
  default     = 0
}

variable "memory_size" {
  description = "Filter the results to a specific memory size in GB."
  default     = 0
}

variable "instance_type_family" {
  description = "Filter the results based on their family name. For example: 'ecs.n4'."
  default     = ""
}

# Zones data source variables

variable "available_disk_category" {
  description = "Filter the results by a specific disk category. Can be either `cloud`, `cloud_efficiency`, `cloud_ssd`, `ephemeral_ssd`."
  default     = "cloud_efficiency"
}

# Vswitches data source variables

variable "vswitch_name_regex" {
  description = "A regex string to filter vswitches by name."
  default     = ""
}

variable "vswitch_tags" {
  description = "A mapping of tags to filter vswitches by tags."
  type        = map(string)
  default     = {}
}

variable "vswitch_resource_group_id" {
  description = "A id string to filter vswitches by resource group id."
  default     = ""
}

# Security groups data source variables

variable "security_group_name_regex" {
  description = "A regex string to filter security groups by name."
  default     = ""
}

variable "security_group_tags" {
  description = "A mapping of tags to filter security groups by it."
  type        = map(string)
  default     = {}
}

variable "security_group_resource_group_id" {
  description = "A id string to filter security groups resource group id."
  default     = ""
}

# Ecs instance variables
variable "number_of_instances" {
  description = "The number of instances to be created."
  default     = 1
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if number_of_instances is 1"
  type        = bool
  default     = false
}

variable "image_id" {
  description = "The image id used to launch one or more ecs instances."
  default     = ""
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  default     = ""
}

variable "credit_specification" {
  description = "Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'."
  default     = "Standard"
}

variable "group_ids" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'security_groups' replaces it."
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "A list of security group ids to associate with."
  type        = list(string)
  default     = []
}

variable "instance_name" {
  description = "Name used on all instances as prefix. Like TF-ECS-Instance-1, TF-ECS-Instance-2."
  default     = "TF-ECS-Instance"
}

variable "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  default     = ""
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  default     = "PayByTraffic"
}

variable "host_name" {
  description = "Host name used on all instances as prefix. Like TF-ECS-Host-Name-1, TF-ECS-Host-Name-2."
  default     = ""
}

variable "password" {
  description = "The password of instance."
  default     = ""
}

variable "kms_encrypted_password" {
  description = "An KMS encrypts password used to an instance. It is conflicted with `password`."
  default     = ""
}

variable "kms_encryption_context" {
  description = "An KMS encryption context used to decrypt `kms_encrypted_password` before creating or updating an instance with `kms_encrypted_password`"
  type        = map(string)
  default     = {}
}

variable "system_disk_category" {
  description = "The system disk category used to launch one or more ecs instances."
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  default     = "40"
}

variable "system_category" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'system_disk_category' replaces it."
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'system_disk_size' replaces it."
  default     = "40"
}

variable "disk_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'data_disks' replaces it."
  default     = "TF_ECS_Disk"
}

variable "disk_category" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'data_disks' replaces it."
  default     = "cloud_efficiency"
}

variable "disk_size" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'data_disks' replaces it."
  default     = "40"
}

variable "disk_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'data_disks' replaces it."
  type        = map(string)

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "number_of_disks" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'data_disks' replaces it."
  default     = 0
}

variable "data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance"
  type        = list(map(string))
  default     = []
}

variable "vswitch_id" {
  description = "The virtual switch ID to launch in VPC. This parameter must be set unless you can create classic network instances."
  default     = ""
}

variable "vswitch_ids" {
  description = "A list of virtual switch IDs to launch in."
  type        = list(string)
  default     = []
}

variable "private_ip" {
  description = "Configure Instance private IP address"
  default     = ""
}

variable "private_ips" {
  description = "A list to configure Instance private IP address"
  type        = list(string)
  default     = []
}

variable "internet_max_bandwidth_in" {
  description = "The maximum internet in bandwidth of instance."
  default     = 200
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  default     = 0
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  default     = "PostPaid"
}

variable "dry_run" {
  description = "Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation. Default to false."
  default     = false
}

variable "user_data" {
  description = "User data to pass to instance on boot"
  default     = ""
}

variable "role_name" {
  description = "Instance RAM role name. The name is provided and maintained by RAM. You can use `alicloud_ram_role` to create a new one."
  default     = ""
}

variable "key_name" {
  description = "The name of key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid."
  default     = ""
}

variable "spot_strategy" {
  description = "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter `instance_charge_type` is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance"
  default     = "NoSpot"
}

variable "spot_price_limit" {
  description = "The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'. Three decimals is allowed at most."
  default     = 0
}

variable "deletion_protection" {
  description = "Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection."
  default     = false
}

variable "force_delete" {
  description = "If it is true, the 'PrePaid' instance will be change to 'PostPaid' and then deleted forcibly. However, because of changing instance charge type has CPU core count quota limitation, so strongly recommand that `Don't modify instance charge type frequentlly in one month`."
  default     = false
}

variable "security_enhancement_strategy" {
  description = "The security enhancement strategy."
  default     = "Active"
}

variable "prepaid_settings" {
  description = "A mapping of fields for Prepaid ECS instances created. "
  type        = map(string)
  default = {
    "period"             = "1"
    "period_unit"        = "Month"
    "renewal_status"     = "Normal"
    "auto_renew_period"  = "1"
    "include_data_disks" = "true"
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'tags' replaces it."
  type        = map(string)
  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}
