variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}

locals {
  user_data = <<EOF
#!/bin/bash
echo "Hello Terraform!"
EOF
}

##################################################################
# Data sources to get VPC, vswitch, security group and ecs image details
##################################################################
data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_vswitches" "all" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*_64"
}

// retrieve 1c2g instance type
data "alicloud_instance_types" "normal" {
  availability_zone = data.alicloud_vswitches.all.vswitches.0.zone_id
  cpu_core_count    = 1
  memory_size       = 2
}

// retrieve 1c2g instance type for Burstable instance
data "alicloud_instance_types" "t5" {
  availability_zone    = data.alicloud_vswitches.all.vswitches.0.zone_id
  instance_type_family = "ecs.t5"
  cpu_core_count       = 1
  memory_size          = 2
}
// retrieve 2c4g instance type for spot instance
data "alicloud_instance_types" "spot" {
  availability_zone = data.alicloud_vswitches.all.vswitches.0.zone_id
  spot_strategy     = "SpotWithPriceLimit"
  cpu_core_count    = 2
  memory_size       = 4
}
// Security Group module for ECS Module
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  region  = var.region
  vpc_id  = data.alicloud_vpcs.default.ids.0
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
  source = "../.."
  region = var.region

  number_of_instances = 1

  name                        = "example-normal"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
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
  source = "../.."
  region = var.region

  number_of_instances = 1

  name                        = "example-with-ram-role"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  role_name = alicloud_ram_role.basic.id
}

module "ecs_with_t5_unlimited" {
  source = "../.."
  region = var.region

  number_of_instances = 1

  name     = "example-with-t5-unlimited"
  image_id = data.alicloud_images.ubuntu.ids.0

  instance_type        = data.alicloud_instance_types.t5.ids.0
  credit_specification = "Unlimited"

  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  role_name = alicloud_ram_role.basic.id
}

// create subscription ecs instances and enable auto renew
module "ecs_for_subscription" {
  source = "../.."
  region = var.region

  number_of_instances = 1

  name                        = "example-for-subscription"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  instance_charge_type = "PrePaid"
  subscription = {
    period             = 1
    period_unit        = "Month"
    renewal_status     = "AutoRenewal"
    auto_renew_period  = 1
    include_data_disks = true
  }
  force_delete = true
}

// create spot instance
module "ecs_spot" {
  source = "../.."
  region = var.region

  number_of_instances = 1

  name                        = "example-spot-instance"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.spot.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  spot_strategy    = "SpotWithPriceLimit"
  spot_price_limit = "0.061"
}

# This instance won't be created
module "ecs_zero" {
  source = "../.."
  region = var.region

  number_of_instances = 0

  name                        = "example-zero"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}