provider "alicloud" {
  version                 = ">=1.60.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-instance"
}

// ECS Instance Resource for Module
resource "alicloud_instance" "this" {
  count                  = var.number_of_instances
  image_id               = var.image_id == "" ? data.alicloud_images.this.images[0].id : var.image_id
  availability_zone      = local.zone_id
  instance_type          = var.instance_type == "" ? data.alicloud_instance_types.this.instance_types[0].id : var.instance_type
  credit_specification   = var.credit_specification
  security_groups        = local.security_group_ids
  vswitch_id             = local.vswitch_ids[count.index]
  instance_name          = var.number_of_instances > 1 || var.use_num_suffix ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
  host_name              = var.host_name
  resource_group_id      = var.resource_group_id
  description            = "An ECS instance came from terraform-alicloud-modules/ecs-instance"
  internet_charge_type   = var.internet_charge_type
  password               = var.password
  kms_encrypted_password = var.kms_encrypted_password
  kms_encryption_context = var.kms_encryption_context
  system_disk_category   = var.system_disk_category
  system_disk_size       = var.system_disk_size
  dynamic "data_disks" {
    for_each = var.data_disks
    content {
      name                 = lookup(data_disks.value, "name", null)
      size                 = lookup(data_disks.value, "size", null)
      category             = lookup(data_disks.value, "category", null)
      encrypted            = lookup(data_disks.value, "encrypted", null)
      snapshot_id          = lookup(data_disks.value, "snapshot_id", null)
      delete_with_instance = lookup(data_disks.value, "delete_with_instance", null)
      description          = lookup(data_disks.value, "description", null)
    }
  }

  private_ip                    = length(var.private_ips) > 0 ? var.private_ips[count.index] : var.private_ip
  internet_max_bandwidth_in     = var.internet_max_bandwidth_in
  internet_max_bandwidth_out    = var.associate_public_ip_address ? var.internet_max_bandwidth_out : 0
  instance_charge_type          = var.instance_charge_type
  period                        = lookup(local.prepaid_settings, "period", null)
  period_unit                   = lookup(local.prepaid_settings, "period_unit", null)
  renewal_status                = lookup(local.prepaid_settings, "renewal_status", null)
  auto_renew_period             = lookup(local.prepaid_settings, "auto_renew_period", null)
  include_data_disks            = lookup(local.prepaid_settings, "include_data_disks", null)
  dry_run                       = var.dry_run
  user_data                     = var.user_data
  role_name                     = var.role_name
  key_name                      = var.key_name
  spot_strategy                 = var.spot_strategy
  spot_price_limit              = var.spot_price_limit
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = var.security_enhancement_strategy
  tags = merge(
    {
      "Name" = var.number_of_instances > 1 || var.use_num_suffix ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
    },
    var.tags,
  )
  volume_tags = merge(
    {
      "Name" = var.number_of_instances > 1 || var.use_num_suffix ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
    },
    var.volume_tags,
  )
}
