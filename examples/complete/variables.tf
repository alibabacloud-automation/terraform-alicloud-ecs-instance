# Ecs instance variables
variable "number_of_instances" {
  description = "The number of instances to be created."
  type        = number
  default     = 1
}

variable "use_num_suffix" {
  description = "Always append numerical suffix(like 001, 002 and so on) to instance name and host name, even if number_of_instances is 1."
  type        = bool
  default     = false
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

variable "name" {
  description = "Name to be used on all resources as prefix. Default to 'TF-Module-ECS-Instance'. The final default name would be TF-Module-ECS-Instance001, TF-Module-ECS-Instance002 and so on."
  type        = string
  default     = "example-with-disks"
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

variable "host_name" {
  description = "Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on."
  type        = string
  default     = "tfEcsInstance"
}

variable "password" {
  description = "The password of instance."
  type        = string
  default     = "YouPassword123456"
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

variable "system_disk_auto_snapshot_policy_id" {
  description = "The ID of the automatic snapshot policy applied to the system disk."
  type        = string
  default     = ""
}

variable "data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance."
  type        = list(map(string))
  default     = [{
    name        = "disk2"
    size        = 20
    category    = "cloud_efficiency"
    description = "disk2"
    encrypted   = true
    delete_with_instance = true
  }]
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

variable "private_ip" {
  description = "Configure Instance private IP address."
  type        = string
  default     = ""
}

variable "internet_max_bandwidth_in" {
  description = "The maximum internet in bandwidth of instance."
  type        = number
  default     = 20
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 10
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address with an instance in a VPC."
  type        = bool
  default     = true
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "dry_run" {
  description = "Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation. Default to false."
  type        = bool
  default     = false
}

variable "spot_strategy" {
  description = "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter 'instance_charge_type' is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance."
  type        = string
  default     = "NoSpot"
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

variable "subscription" {
  description = "A mapping of fields for Prepaid ECS instances created. "
  type        = map(string)
  default = {
    period             = 1
    period_unit        = "Month"
    renewal_status     = "Normal"
    auto_renew_period  = 1
    include_data_disks = true
  }
}

# Depreceted parameters
variable "instance_name" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'name' instead."
  default     = ""
}
variable "group_ids" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'security_group_ids' instead."
  type        = list(string)
  default     = []
}

variable "system_category" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'system_disk_category' instead."
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'system_disk_size' replaces it."
  type        = number
  default     = 40
}

variable "disk_name" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' 'name' instead."
  default     = "TF_ECS_Disk"
}

variable "disk_category" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' 'category' instead."
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

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance."
  }
}
variable "instance_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'tags' replaces it."
  type        = map(string)
  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}
variable "number_of_disks" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'data_disks' instead."
  type        = number
  default     = 0
}
