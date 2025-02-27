variable "region" {
  default     = "cn-hangzhou"
  type        = string
  description = "The region where the instance is located."
}

variable "instances_number" {
  description = "The number of instances to be created."
  default     = 1
  type        = number
}