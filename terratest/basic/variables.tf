variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

# Ecs instance variables
variable "image_id" {
  description = "The image id used to launch one or more ecs instances."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  type        = string
  default     = ""
}

variable "credit_specification" {
  description = "Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'."
  default     = "Standard"
}

variable "security_groups" {
  description = "A list of security group ids to associate with."
  type        = list(string)
  default     = []
}

variable "vswitch_ids" {
  description = "A list of vswitch ids to associate with."
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
  default     = "TF-ECS-Host-Name"
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

variable "data_disks" {
  description = "Whether to change instance disks charge type when changing instance charge type."
  type        = list(map(string))
  default     = []
}

variable "private_ips" {
  description = "Configure Instance private IP address"
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

variable "dry_run" {
  description = "Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation. It is valid when `instance_charge_type` is 'PrePaid'. Default to false."
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
