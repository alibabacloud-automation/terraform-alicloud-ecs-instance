variable "region" {
  default     = "cn-hangzhou"
  type        = string
  description = "The region where the instance is located."
}

variable "zone_id" {
  description = "The zone where the instance is located."
  type        = string
  default     = "cn-hangzhou-i"
}

