data "alicloud_zones" "default" {}
##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
// retrieve 1c2g instance type
data "alicloud_instance_types" "normal" {
  availability_zone = data.alicloud_zones.default.ids.0
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

resource "alicloud_ram_role" "role" {
  name        = "testrole1946"
  document    = <<EOF
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
  description = "this is a role test."
  force       = true
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = "my_module_vpc"
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = "my_module_vswitch"
  vswitch_cidrs      = ["172.16.1.0/24"]
  availability_zones = [data.alicloud_zones.default.ids.0]
}

// Security Group module for ECS Module
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  vpc_id  = module.vpc.vpc_id
  version = "~> 2.0"
}

resource "alicloud_disk_attachment" "this_ecs" {
  count = var.number_of_instances

  disk_id     = alicloud_disk.this[count.index].id
  instance_id = module.ecs.this_instance_id[count.index]
}

resource "alicloud_disk" "this" {
  count = var.number_of_instances

  zone_id = module.ecs.this_availability_zone[count.index]
  size              = 20
}

module "ecs" {
  source  = "../.."
  number_of_instances           = var.number_of_instances
  name                          = var.name
  image_id                      = data.alicloud_images.ubuntu.ids.0
  instance_type                 = data.alicloud_instance_types.normal.ids.0
  vswitch_id                    = module.vpc.vswitch_ids[0]
  security_group_ids            = [module.security_group.this_security_group_id]
  associate_public_ip_address   = true
  internet_max_bandwidth_out    = var.internet_max_bandwidth_out
  use_num_suffix                = var.use_num_suffix
  description                   = var.description
  internet_charge_type          = var.internet_charge_type
  host_name                     = var.host_name
  password                      = var.password
  system_disk_category          = "cloud_efficiency"
  system_disk_size              = var.system_disk_size
  private_ip                    = var.private_ip
  instance_charge_type          = var.instance_charge_type
  dry_run                       = var.dry_run
  role_name                     = alicloud_ram_role.role.name
  spot_strategy                 = "NoSpot"
  spot_price_limit              = 0
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = var.security_enhancement_strategy
  subscription                  = var.subscription
  tags                          = var.tags
  volume_tags                   = var.volume_tags
}
