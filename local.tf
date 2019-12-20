locals {
  vswitch_name_regex        = var.vswitch_name_regex != "" ? var.vswitch_name_regex : var.filter_with_name_regex
  vswitch_tags              = length(var.vswitch_tags) > 0 ? var.vswitch_tags : var.filter_with_tags
  vswitch_resource_group_id = var.vswitch_resource_group_id != "" ? var.vswitch_resource_group_id : var.filter_with_resource_group_id
  vswitch_ids               = length(var.vswitch_ids) > 0 ? var.vswitch_ids : local.vswitch_name_regex != "" || length(local.vswitch_tags) > 0 || local.vswitch_resource_group_id != "" ? data.alicloud_vswitches.this.ids : []
  sg_name_regex             = var.security_group_name_regex != "" ? var.security_group_name_regex : var.filter_with_name_regex
  sg_tags                   = length(var.security_group_tags) > 0 ? var.security_group_tags : var.filter_with_tags
  sg_resource_group_id      = var.security_group_resource_group_id != "" ? var.security_group_resource_group_id : var.filter_with_resource_group_id
  security_group_ids        = length(var.security_groups) > 0 ? var.security_groups : local.sg_name_regex != "" || length(local.sg_tags) > 0 || local.sg_resource_group_id != "" ? data.alicloud_security_groups.this.ids : []
  zone_id                   = var.vswitch_id == "" && var.vswitch_ids == [] ? data.alicloud_vswitches.this.vswitches.0.zone_id : data.alicloud_vswitches.this1.vswitches.0.zone_id
  prepaid_settings          = var.internet_charge_type == "PostPaid" ? {} : var.prepaid_settings
}

data "alicloud_images" "this" {
  most_recent = var.most_recent
  owners      = var.owners
  name_regex  = var.image_name_regex
}
// Instance_types data source for instance_type
data "alicloud_instance_types" "this" {
  cpu_core_count       = var.cpu_core_count == 0 ? null : var.cpu_core_count
  memory_size          = var.memory_size == 0 ? null : var.memory_size
  instance_type_family = var.instance_type_family == "" ? null : var.instance_type_family
  availability_zone    = local.zone_id
}

data "alicloud_security_groups" "this" {
  name_regex        = local.sg_name_regex
  tags              = local.sg_tags
  resource_group_id = local.sg_resource_group_id
}

data "alicloud_vswitches" "this" {
  name_regex        = local.vswitch_name_regex
  tags              = local.vswitch_tags
  resource_group_id = local.vswitch_resource_group_id
}

data "alicloud_vswitches" "this1" {
  ids = var.vswitch_ids == [] ? var.vswitch_id == "" ? null : [var.vswitch_id] : var.vswitch_ids
}