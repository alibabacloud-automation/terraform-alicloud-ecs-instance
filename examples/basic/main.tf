variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region  = var.region
  profile = var.profile
}

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}

#############################################################
# create VPC, vswitch and security group
#############################################################
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "tf_module"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones[0].id
}

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

data "alicloud_images" "centos" {
  most_recent   = true
  name_regex    = "^centos_7*"
  instance_type = data.alicloud_instance_types.normal.ids.0
}
// retrieve 1c2g instance type
data "alicloud_instance_types" "normal" {
  availability_zone    = alicloud_vswitch.default.zone_id
  instance_type_family = "ecs.n1"
  cpu_core_count       = 2
  memory_size          = 4
}

data "alicloud_instance_types" "prepaid" {
  availability_zone    = alicloud_vswitch.default.zone_id
  instance_type_family = "ecs.n4"
  instance_charge_type = "PrePaid"
  cpu_core_count       = 1
  memory_size          = 2
}

// retrieve 1c2g instance type for Burstable instance
data "alicloud_instance_types" "t5" {
  availability_zone    = alicloud_vswitch.default.zone_id
  instance_type_family = "ecs.t5"
  cpu_core_count       = 1
  memory_size          = 2
}
// retrieve 2c4g instance type for spot instance
data "alicloud_instance_types" "spot" {
  availability_zone = alicloud_vswitch.default.zone_id
  spot_strategy     = "SpotWithPriceLimit"
  cpu_core_count    = 2
  memory_size       = 4
}
// Security Group module for ECS Module
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  profile = var.profile
  region  = var.region
  vpc_id  = alicloud_vpc.default.id
  version = "~> 2.0"
}

// Create a role name
resource "alicloud_ram_role" "basic" {
  name     = "example-with-role-name"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "apigateway.aliyuncs.com",
              "ecs.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
    }
  EOF
}

module "ecs" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 1

  name                        = "example-normal"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  user_data = local.user_data

  system_disk_category = "cloud_ssd"
  system_disk_size     = 50

  data_disks = [
    {
      name        = "example"
      category    = "cloud_ssd"
      size        = "20"
      volume_size = 5
      encrypted   = true
    }
  ]

  tags = {
    Env      = "Private"
    Location = "Secret"
  }
}

module "ecs_with_multi_images" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 3

  name                        = "example-multi-image"
  image_ids                   = [data.alicloud_images.ubuntu.ids.0, data.alicloud_images.centos.ids.0]
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  user_data = local.user_data

  system_disk_category = "cloud_ssd"
  system_disk_size     = 50

  data_disks = [
    {
      name        = "example"
      category    = "cloud_ssd"
      size        = "20"
      volume_size = 5
      encrypted   = true
    }
  ]

  tags = {
    Env      = "Private"
    Location = "Secret"
  }
}

module "ecs_with_ram_role" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 1

  name           = "example-with-ram-role"
  use_num_suffix = true

  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  role_name = alicloud_ram_role.basic.id
}

// create subscription ecs instances and enable auto renew
module "ecs_for_subscription" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 1

  name                        = "example-for-subscription"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.prepaid.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  instance_charge_type = "PrePaid"
  subscription = {
    period_unit        = "Month"
    renewal_status     = "AutoRenewal"
    auto_renew_period  = 1
    include_data_disks = true
  }
  force_delete = true
}

// create spot instance
module "ecs_spot" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 1

  name           = "example-spot-instance"
  use_num_suffix = true

  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.spot.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  spot_strategy    = "SpotWithPriceLimit"
  spot_price_limit = "0.061"
}

# This instance won't be created
module "ecs_zero" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 0

  name                        = "example-zero"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

// create instance with auto snapshot policy
module "ecs-auto-snap-shot-policy" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 1

  name                        = "example-normal"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
  //  system_disk_auto_snapshot_policy_id = "sp-bp1axyxxxxxxxxxx"
  user_data = local.user_data

  system_disk_category = "cloud_ssd"
  system_disk_size     = 50

  data_disks = [
    {
      name        = "example"
      category    = "cloud_ssd"
      size        = "20"
      volume_size = 5
      encrypted   = true
      //  auto_snapshot_policy_id = "sp-bp1axyxxxxxxxxxx"
    }
  ]

  tags = {
    Env      = "Private"
    Location = "Secret"
  }
}

resource "alicloud_ecs_network_interface" "default" {
  count              = 2
  vswitch_id         = alicloud_vswitch.default.id
  security_group_ids = [module.security_group.this_security_group_id]
}

module "ecs_with_multi_eni" {
  source  = "../.."
  profile = var.profile
  region  = var.region

  number_of_instances = 4

  name                        = "example-multi-eni"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  network_interface_ids = [alicloud_ecs_network_interface.default.0.id, "", alicloud_ecs_network_interface.default.1.id]

  user_data = local.user_data

  system_disk_category = "cloud_ssd"
  system_disk_size     = 50

  data_disks = [
    {
      name        = "example"
      category    = "cloud_ssd"
      size        = "20"
      volume_size = 5
      encrypted   = true
    }
  ]

  tags = {
    Env      = "Private"
    Location = "Secret"
  }
}


# create instance with ipv6 address
resource "alicloud_vpc" "ipv6" {
  vpc_name    = "tf_module"
  cidr_block  = "172.16.0.0/12"
  enable_ipv6 = true
}

resource "alicloud_vswitch" "ipv6" {
  vpc_id               = alicloud_vpc.ipv6.id
  cidr_block           = "172.16.0.0/21"
  zone_id              = data.alicloud_zones.default.zones[0].id
  ipv6_cidr_block_mask = "22"
}

data "alicloud_instance_types" "ipv6" {
  availability_zone                 = alicloud_vswitch.default.zone_id
  system_disk_category              = "cloud_efficiency"
  cpu_core_count                    = 4
  minimum_eni_ipv6_address_quantity = 1
}

resource "alicloud_security_group" "ipv6" {
  name   = "tf_module"
  vpc_id = alicloud_vpc.ipv6.id
}

module "ecs_with_ipv6_address" {
  source  = "../.."
  profile = var.profile

  number_of_instances = 1

  name           = "example-with-ipv6-address"
  use_num_suffix = true

  image_id             = data.alicloud_images.ubuntu.ids.0
  instance_type        = data.alicloud_instance_types.ipv6.ids.0
  vswitch_id           = alicloud_vswitch.ipv6.id
  security_group_ids   = [alicloud_security_group.ipv6.id]
  system_disk_category = "cloud_efficiency"

  ipv6_addresses = [cidrhost(alicloud_vswitch.ipv6.ipv6_cidr_block, 64)]
}
