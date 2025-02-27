locals {
  subscription       = var.instance_charge_type == "PostPaid" ? {} : var.subscription
  name               = var.name != "" ? var.name : var.instance_name != "" ? var.instance_name : "TF-Module-ECS-Instance"
  system_disk_name   = var.system_disk_name != "" ? var.system_disk_name : local.name
  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : var.group_ids
}