variable "most_recent" {
  description = "If more than one result are returned, select the most recent one."
  type        = bool
  default     = true
}

variable "owners" {
  description = "Filter results by a specific image owner. Valid items are 'system', 'self', 'others', 'marketplace'."
  type        = string
  default     = "system"
}

variable "image_name_regex" {
  description = "A regex string to filter resulting images by name."
  type        = string
  default     = "^ubuntu_18.*64"
}

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

variable "instance_type_family" {
  description = "The instance type family used to retrieve bare metal CPU instance type. Valid values: [\"ecs.scch5\", \"ecs.sccg5\"]"
  type        = string
  default     = "ecs.scch5"
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  type        = string
  default     = ""
}

variable "cpu_core_count" {
  description = "core count used to retrieve instance types"
  type        = number
  default     = 0
}

variable "memory_size" {
  description = "Memory size used to retrieve instance types."
  type        = number
  default     = 0
}

variable "security_group_ids" {
  description = "A list of security group ids to associate with."
  type        = list(string)
  default     = []
}

variable "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  type        = string
  default     = ""
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
  description = "An KMS encryption context used to decrypt 'kms_encrypted_password' before creating or updating an instance with 'kms_encrypted_password'"
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

variable "system_disk_auto_snapshot_policy_id" {
  description = "The ID of the automatic snapshot policy applied to the system disk."
  type        = string
  default     = ""
}

variable "data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance"
  type        = list(map(string))
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

variable "private_ip" {
  description = "Configure Instance private IP address"
  type        = string
  default     = ""
}

variable "private_ips" {
  description = "A list to configure Instance private IP address"
  type        = list(string)
  default     = []
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 0
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
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

variable "user_data" {
  description = "User data to pass to instance on boot"
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

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created = "Terraform"
    Source  = "alibaba/ecs-instance/alicloud//modules/super-computing-cluster-cpu"
  }
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}

variable "hpc_cluster_id" {
  description = "The ID of the Elastic High Performance Computing (E-HPC) cluster to which to assign the instance."
  type        = string
  default     = null
}
