data "alicloud_zones" "default" {
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_images" "default" {
  name_regex = "^centos_6"
  owners     = "system"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

data "alicloud_ecs_auto_snapshot_policies" "default" {
}

resource "alicloud_ecs_disk" "default" {
  zone_id = data.alicloud_zones.default.zones.0.id
  size    = var.system_disk_size
}

resource "alicloud_ecs_snapshot" "default" {
  disk_id  = alicloud_ecs_disk_attachment.default.disk_id
  category = "standard"
  force    = var.force_delete
}

resource "alicloud_ecs_disk_attachment" "default" {
  disk_id     = alicloud_ecs_disk.default.id
  instance_id = module.ecs_instance.this_instance_id[0]
}

resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = "key_pair_name_2022"
}

resource "alicloud_ram_role" "default" {
  name     = "tf-ram-name-2022"
  document = var.document
}

resource "alicloud_kms_key" "kms" {
  key_usage              = "ENCRYPT/DECRYPT"
  pending_window_in_days = var.pending_window_in_days
  status                 = "Enabled"
}

resource "alicloud_kms_ciphertext" "kms" {
  plaintext = "test"
  key_id    = alicloud_kms_key.kms.id
  encryption_context = {
    test = "test"
  }
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/12"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

module "ecs_instance" {
  source = "../.."

  number_of_instances = 1

  instance_type      = data.alicloud_instance_types.default.instance_types.0.id
  image_id           = data.alicloud_images.default.images.0.id
  vswitch_ids        = [module.vpc.this_vswitch_ids[0]]
  security_group_ids = [module.security_group.this_security_group_id]
  description        = var.description
}

module "example" {
  source = "../.."

  number_of_instances = 1

  image_id                            = data.alicloud_images.default.images.0.id
  image_ids                           = data.alicloud_images.default.ids
  instance_type                       = data.alicloud_instance_types.default.instance_types.0.id
  security_group_ids                  = [module.security_group.this_security_group_id]
  vswitch_id                          = module.vpc.this_vswitch_ids[0]
  vswitch_ids                         = module.vpc.this_vswitch_ids
  private_ip                          = var.private_ip
  private_ips                         = var.private_ips
  name                                = var.name
  use_num_suffix                      = true
  host_name                           = var.host_name
  resource_group_id                   = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  description                         = var.description
  internet_charge_type                = var.internet_charge_type
  password                            = var.password
  kms_encrypted_password              = var.kms_encrypted_password
  kms_encryption_context              = alicloud_kms_ciphertext.kms.encryption_context
  system_disk_category                = "cloud_efficiency"
  system_disk_size                    = var.system_disk_size
  system_disk_auto_snapshot_policy_id = data.alicloud_ecs_auto_snapshot_policies.default.policies.0.id
  data_disks = [
    {
      name                    = "data_disks_name"
      size                    = "20"
      category                = "cloud_ssd"
      encrypted               = false
      snapshot_id             = alicloud_ecs_snapshot.default.id
      delete_with_instance    = true
      description             = "tf-description"
      auto_snapshot_policy_id = data.alicloud_ecs_auto_snapshot_policies.default.policies.0.id
    }
  ]
  associate_public_ip_address   = true
  internet_max_bandwidth_out    = var.internet_max_bandwidth_out
  instance_charge_type          = var.instance_charge_type
  subscription                  = var.subscription
  dry_run                       = var.dry_run
  user_data                     = var.user_data
  role_name                     = alicloud_ram_role.default.id
  key_name                      = alicloud_ecs_key_pair.default.id
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = "Active"
  credit_specification          = null
  spot_strategy                 = "NoSpot"
  spot_price_limit              = 0
  tags                          = var.tags
  volume_tags                   = var.volume_tags

}