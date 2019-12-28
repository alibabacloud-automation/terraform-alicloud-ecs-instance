
resource "alicloud_disk" "disk" {
  availability_zone = module.ecs-instance.this_availability_zone
  name              = "CreateByTerraform"
  category          = "cloud_efficiency"
  size              = "70"
}

// Attach ECS disks to instances for Module
resource "alicloud_disk_attachment" "disk_attach" {
  disk_id     = alicloud_disk.disk.id
  instance_id = module.ecs-instance.this_instance_id[0]
}

resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
  name   = "CreateByTerraform"
}

resource "alicloud_vpc" "default" {
  cidr_block = "172.16.0.0/12"
  name       = "CreateByTerraform"
}

resource "alicloud_vswitch" "default" {
  availability_zone = module.ecs-instance.this_availability_zone
  cidr_block        = "172.16.0.0/24"
  vpc_id            = alicloud_vpc.default.id
  name              = "CreateByTerraform"
}

module "ecs-instance" {
  source                        = "../../"
  image_id                      = var.image_id
  instance_type                 = var.instance_type
  security_groups               = length(var.security_groups) == 0 ? [alicloud_security_group.default.id] : var.security_groups
  vswitch_ids                   = length(var.vswitch_ids) == 0 ? [alicloud_vswitch.default.id] : var.vswitch_ids
  name                          = var.name
  credit_specification          = var.credit_specification
  resource_group_id             = var.resource_group_id
  internet_charge_type          = var.internet_charge_type
  host_name                     = var.host_name
  password                      = var.password
  kms_encrypted_password        = var.kms_encrypted_password
  kms_encryption_context        = var.kms_encryption_context
  system_disk_category          = var.system_disk_category
  system_disk_size              = var.system_disk_size
  data_disks                    = var.data_disks
  private_ips                   = var.private_ips
  internet_max_bandwidth_in     = var.internet_max_bandwidth_in
  internet_max_bandwidth_out    = var.internet_max_bandwidth_out
  associate_public_ip_address   = var.associate_public_ip_address
  instance_charge_type          = var.instance_charge_type
  subscription                  = var.subscription
  dry_run                       = var.dry_run
  user_data                     = var.user_data
  role_name                     = var.role_name
  key_name                      = var.key_name
  spot_strategy                 = var.spot_strategy
  spot_price_limit              = var.spot_price_limit
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = var.security_enhancement_strategy
  tags                          = var.tags
  volume_tags                   = var.volume_tags
}
