
// ECS Disk Resource for Module
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

// ECS Security Group Resource for Module
resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
  name   = "CreateByTerraform"
}

// ECS Vpc Resource for Module
resource "alicloud_vpc" "default" {
  cidr_block = "172.16.0.0/12"
  name       = "CreateByTerraform"
}

// ECS Vswitch Resource for Module
resource "alicloud_vswitch" "default" {
  availability_zone = module.ecs-instance.this_availability_zone
  cidr_block        = "172.16.0.0/24"
  vpc_id            = alicloud_vpc.default.id
  name              = "CreateByTerraform"
}

module "ecs-instance" {
  source          = "../../"
  security_groups = [alicloud_security_group.default.id]
  vswitch_ids     = [alicloud_vswitch.default.id]
  instance_name   = "CreateByTerraform"
}
