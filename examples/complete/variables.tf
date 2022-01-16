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

variable "system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "private_ip" {
  description = "Configure Instance private IP address."
  type        = string
  default     = "8.214.23.168"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 10
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
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {"info":"instance tag"}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {"name":"volume_tags"}
}