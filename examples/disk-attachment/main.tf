provider "alicloud" {
  region = var.region
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

# retrieve 1c2g instance type
data "alicloud_instance_types" "normal" {
  availability_zone = alicloud_vswitch.default.zone_id
  cpu_core_count    = 1
  memory_size       = 2
}

# Security Group module for ECS Module
module "security_group" {
  source = "alibaba/security-group/alicloud"

  vpc_id  = alicloud_vpc.default.id
  version = "~> 2.0"
}

module "ecs" {
  source = "../.."

  number_of_instances = 1

  name                        = "example-with-disks"
  image_id                    = data.alicloud_images.ubuntu.ids[0]
  instance_type               = data.alicloud_instance_types.normal.ids[0]
  vswitch_id                  = alicloud_vswitch.default.id
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
}

resource "alicloud_disk_attachment" "this_ecs" {
  count = var.instances_number

  disk_id     = alicloud_disk.this[count.index].id
  instance_id = module.ecs.this_instance_id[count.index]
}

resource "alicloud_disk" "this" {
  count = var.instances_number

  zone_id = module.ecs.this_availability_zone[count.index]
  size    = 20
}