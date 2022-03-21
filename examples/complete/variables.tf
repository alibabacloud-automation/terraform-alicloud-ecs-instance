#alicloud_kms_key
variable "pending_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  type        = string
  default     = "30"
}

#alicloud_ram_role
variable "document" {
  description = "Authorization strategy of the RAM role."
  type        = string
  default     = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "apigateway.aliyuncs.com",
            "ecs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
}

# Ecs instance variables
variable "private_ip" {
  description = "Configure Instance private IP address."
  type        = string
  default     = "172.16.0.10"
}

variable "private_ips" {
  description = "A list to configure Instance private IP address"
  type        = list(string)
  default     = ["172.16.0.10"]
}

variable "name" {
  description = "Name to be used on all resources as prefix. Default to 'TF-Module-ECS-Instance'. The final default name would be TF-Module-ECS-Instance001, TF-Module-ECS-Instance002 and so on."
  type        = string
  default     = "tf-testacc-name"
}

variable "host_name" {
  description = "Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on."
  type        = string
  default     = "tf-testacc-host-name"
}

variable "description" {
  description = "Description of all instances."
  type        = string
  default     = "tf-testacc-description"
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  type        = string
  default     = "PayByTraffic"
}

variable "password" {
  description = "The password of instance."
  type        = string
  default     = "YourPassword123!"
}

variable "kms_encrypted_password" {
  description = "An KMS encrypts password used to an instance. It is conflicted with 'password'."
  type        = string
  default     = "YourPassword123!"
}

variable "system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
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

variable "subscription" {
  description = "A mapping of fields for Prepaid ECS instances created. "
  type        = map(string)
  default = {
    period             = 2
    period_unit        = "Month"
    renewal_status     = "AutoRenewal"
    auto_renew_period  = 2
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
  default     = "tf-user-data"
}

variable "deletion_protection" {
  description = "Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection."
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "If it is true, the 'PrePaid' instance will be change to 'PostPaid' and then deleted forcibly. However, because of changing instance charge type has CPU core count quota limitation, so strongly recommand that 'Don't modify instance charge type frequentlly in one month'."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Name = "ECS"
  }
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default = {
    Name = "tf-testacc-ecs"
  }
}