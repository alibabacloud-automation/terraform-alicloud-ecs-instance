# ECS Instance Resource for Module
resource "alicloud_instance" "this" {
  count                               = var.number_of_instances
  image_id                            = element(distinct(compact(concat([var.image_id], var.image_ids))), count.index)
  instance_type                       = var.instance_type
  security_groups                     = local.security_group_ids
  vswitch_id                          = element(distinct(compact(concat([var.vswitch_id], var.vswitch_ids))), count.index)
  private_ip                          = length(var.private_ips) > 0 ? var.private_ips[count.index] : var.private_ip
  instance_name                       = var.number_of_instances > 1 || var.use_num_suffix ? format("%s%03d", local.name, count.index + 1) : local.name
  host_name                           = var.host_name == "" ? "" : var.number_of_instances > 1 || var.use_num_suffix ? format("%s%03d", var.host_name, count.index + 1) : var.host_name
  resource_group_id                   = var.resource_group_id
  description                         = var.description
  internet_charge_type                = var.internet_charge_type
  password                            = var.password
  kms_encrypted_password              = var.kms_encrypted_password
  kms_encryption_context              = var.kms_encryption_context
  system_disk_category                = var.system_disk_category
  system_disk_size                    = var.system_disk_size
  system_disk_auto_snapshot_policy_id = var.system_disk_auto_snapshot_policy_id
  dynamic "data_disks" {
    for_each = var.data_disks
    content {
      name                    = lookup(data_disks.value, "name", var.disk_name)
      size                    = lookup(data_disks.value, "size", var.disk_size)
      category                = lookup(data_disks.value, "category", var.disk_category)
      encrypted               = lookup(data_disks.value, "encrypted", null)
      snapshot_id             = lookup(data_disks.value, "snapshot_id", null)
      delete_with_instance    = lookup(data_disks.value, "delete_with_instance", null)
      description             = lookup(data_disks.value, "description", null)
      auto_snapshot_policy_id = lookup(data_disks.value, "auto_snapshot_policy_id", null)
    }
  }
  internet_max_bandwidth_out    = var.associate_public_ip_address ? var.internet_max_bandwidth_out : 0
  instance_charge_type          = var.instance_charge_type
  period                        = lookup(local.subscription, "period", null)
  period_unit                   = lookup(local.subscription, "period_unit", null)
  renewal_status                = lookup(local.subscription, "renewal_status", null)
  auto_renew_period             = lookup(local.subscription, "auto_renew_period", null)
  include_data_disks            = lookup(local.subscription, "include_data_disks", null)
  dry_run                       = var.dry_run
  user_data                     = var.user_data
  role_name                     = var.role_name
  key_name                      = var.key_name
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = var.security_enhancement_strategy
  credit_specification          = var.credit_specification != "" ? var.credit_specification : null
  spot_strategy                 = var.spot_strategy
  spot_price_limit              = var.spot_price_limit
  operator_type                 = var.operator_type
  status                        = var.status
  tags = merge(
    {
      Name = var.number_of_instances > 1 || var.use_num_suffix ? format("%s%03d", local.name, count.index + 1) : local.name
    },
    var.tags,
  )
  volume_tags = merge(
    {
      Name = var.number_of_instances > 1 || var.use_num_suffix ? format("%s%03d", local.name, count.index + 1) : local.name
    },
    var.volume_tags,
  )
}