variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}

variable "instances_number" {
  default = 2
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
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

// Security Group module for ECS Module
module "security_group" {
  source  = "alibaba/security-group/alicloud"
  region  = var.region
  vpc_id  = data.alicloud_vpcs.default.ids.0
  version = "~> 2.0"
}

module "ecs" {
  source = "../.."
  region = var.region

  number_of_instances = var.instances_number

  name                        = "example-with-eips"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = data.alicloud_instance_types.normal.ids.0
  vswitch_id                  = data.alicloud_vswitches.all.ids.0
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = false
}

resource "alicloud_eip_association" "this_ecs" {
  count = var.instances_number

  instance_id   = module.ecs.this_instance_id[count.index]
  allocation_id = alicloud_eip.this[count.index].id
}

resource "alicloud_eip" "this" {
  count = var.instances_number

  bandwidth = 10
}