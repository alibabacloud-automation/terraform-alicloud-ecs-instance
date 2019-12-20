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
  availability_zone = module.multi-instance.this_availability_zone
  cidr_block        = "172.16.0.0/24"
  vpc_id            = alicloud_vpc.default.id
  name              = "CreateByTerraform"
}

module "multi-instance" {
  source              = "../../"
  number_of_instances = "3"
  security_groups     = [alicloud_security_group.default.id]
  vswitch_id          = alicloud_vswitch.default.id
  private_ips         = ["172.16.0.10", "172.16.0.12", "172.16.0.14"]
  instance_name       = "CreateByTerraform"
}