variable "availability_zone" {
  description = "The available zone to launch ecs instance and other resources."
  default     = ""
}

variable "number_format" {
  description = "The number format used to output."
  default     = "%02d"
}

# Image variables
variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  default     = "^ubuntu_14.*_64"
}

# Instance typs variables
variable "cpu_core_count" {
  description = "CPU core count used to fetch instance types."
  default     = 1
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  default     = 2
}

# VSwitch  ID
variable "vswitch_id" {
  description = "The vswitch id used to launch one or more instances."
}

# Security Group variables
variable "group_ids" {
  description = "List of security group ids used to join ECS instances."
  type        = "list"
}

# Key pair variables
variable "key_name" {
  description = "The key pair name used to attach one or more instances."
  default     = ""
}

# Disk variables
variable "disk_name" {
  description = "Name used on all disks as prefix. Like TF_ECS_Disk-1, TF_ECS_Disk-2."
  default     = "TF_ECS_Disk"
}

variable "disk_category" {
  description = "The data disk category used to launch one or more data disks."
  default     = "cloud_efficiency"
}

variable "disk_size" {
  description = "The data disk size used to launch one or more data disks."
  default     = "40"
}

variable "disk_tags" {
  description = "Used to mark specified ecs data disks."
  type        = "map"

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "number_of_disks" {
  description = "The number of launching disks one time."
  default     = 0
}

# Ecs instance variables
variable "image_id" {
  description = "The image id used to launch one or more ecs instances."
  default     = ""
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  default     = ""
}

variable "system_category" {
  description = "The system disk category used to launch one or more ecs instances."
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  default     = "40"
}

variable "instance_name" {
  description = "Name used on all instances as prefix. Like TF-ECS-Instance-1, TF-ECS-Instance-2."
  default     = "TF-ECS-Instance"
}

variable "host_name" {
  description = "Host name used on all instances as prefix. Like TF-ECS-Host-Name-1, TF-ECS-Host-Name-2."
  default     = "TF-ECS-Host-Name"
}

variable "password" {
  description = "The password of instance."
  default     = ""
}

variable "private_ips" {
  description = "Configure Instance private IP address"
  type        = "list"
  default     = [""]
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  default     = "PayByTraffic"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance.."
  default     = 10
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  default     = "PostPaid"
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  default     = 1
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = "map"

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-instance"
  }
}

variable "number_of_instances" {
  description = "The number of launching instances one time."
  default     = 1
}

variable "user_data" {
  description = "User data to pass to instance on boot"
  default     = ""
}
