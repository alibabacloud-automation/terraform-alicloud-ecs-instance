provider "alicloud" {
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = var.skip_region_validation
}
locals {
  // This type of instance contains the following instance type families
  instance_type_families = ["ecs.scch5", "ecs.sccg5"]
}


data "alicloud_instance_types" "this" {
  instance_type_family = var.instance_type_family != "" && contains(local.instance_type_families, var.instance_type_family) ? var.instance_type_family : "ecs.scch5"
  instance_charge_type = var.instance_charge_type
  cpu_core_count       = var.cpu_core_count > 0 ? var.cpu_core_count : null
  memory_size          = var.memory_size > 0 ? var.memory_size : null
  availability_zone    = length(var.vswitch_ids) > 0 || var.vswitch_id != "" ? data.alicloud_vswitches.this.vswitches.0.zone_id : null
}

data "alicloud_vswitches" "this" {
  ids = length(var.vswitch_ids) > 0 ? var.vswitch_ids : [var.vswitch_id]
}
data "alicloud_images" "this" {
  most_recent = var.most_recent
  owners      = var.owners
  name_regex  = var.image_name_regex
}
module "ecs-instance" {
  source = "../../"

  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = var.skip_region_validation

  number_of_instances = var.number_of_instances

  // Specify a ecs image
  image_id = var.image_id != "" ? var.image_id : data.alicloud_images.this.ids.0

  // Specify instance type
  instance_type = var.instance_type != "" ? var.instance_type : data.alicloud_instance_types.this.ids.0

  // Specify network setting
  security_group_ids = var.security_group_ids
  vswitch_id         = var.vswitch_id
  vswitch_ids        = var.vswitch_ids
  private_ip         = var.private_ip
  private_ips        = var.private_ips


  // Specify instance basic attributes
  instance_name     = "TF-super-computing-cluster-cpu"
  use_num_suffix    = true
  tags              = var.tags
  resource_group_id = var.resource_group_id
  user_data         = var.user_data

  // Specify instance charge attributes
  internet_charge_type        = var.internet_charge_type
  internet_max_bandwidth_out  = var.internet_max_bandwidth_out
  associate_public_ip_address = var.associate_public_ip_address
  instance_charge_type        = var.instance_charge_type
  prepaid_settings            = var.prepaid_settings
  dry_run                     = var.dry_run


  // Specify instance disk setting
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  data_disks           = var.data_disks
  volume_tags          = var.volume_tags

  // Specify instance access setting
  password               = var.password
  kms_encrypted_password = var.kms_encrypted_password
  kms_encryption_context = var.kms_encryption_context
  key_name               = var.key_name

  // Attach ecs instance to a RAM role
  role_name = var.role_name

  // Security Setting
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = var.security_enhancement_strategy

  // Set the useless parameters
  credit_specification = null
  spot_strategy        = "NoSpot"
}
