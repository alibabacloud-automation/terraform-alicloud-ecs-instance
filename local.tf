locals {
  subscription = var.instance_charge_type == "PostPaid" ? {} : var.subscription
  # compatible with old parametes instance_tags and disk_tags
  instance_tags      = length(var.tags) > 0 ? var.tags : var.instance_tags
  volume_tags        = length(var.volume_tags) > 0 ? var.volume_tags : var.disk_tags
  name               = var.name != "" ? var.name : var.instance_name != "" ? var.instance_name : "TF-Module-ECS-Instance"
  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : var.group_ids
}