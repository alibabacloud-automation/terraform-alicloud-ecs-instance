Alicloud ECS Instance Terraform Module In VPC
terraform-alicloud-ecs-instance
=====================================================================

A terraform module to provide ECS instances in Alicloud VPC.

- It assumes you have one VPC and VSwitch and you want to put the new instances to the VPC. If not, you can launch a new one by module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)
- It assumes you have several security groups in the VPC and you want to join the new instances into them. If not, you can launch one or more groups by module [terraform-alicloud-security-group](https://github.com/alibaba/terraform-alicloud-security-group)
- If you have no idea some parametes, such as instance type, availability zone and image id,
  the module will provide default values according to some input parameters, such as `image_name_regex`, `cpu_core_count`, `memory_size` and so on.


Module Input Variables
----------------------

The module aim to create one or more instances and disks in the VPC. Its input variables contains VSwitch, Security Group, ECS Disks and ECS Instances.

#### Common Input vairables

- `alicloud_access_key` - The Alicloud Access Key ID to launch resources
- `alicloud_secret_key` - The Alicloud Access Secret Key to launch resources
- `region` - The region to launch resources
- `availability_zone` - The availability zone ID to launch ECS Instances and ECS Disks - default to a zone ID retrieved by zones' data source
- `number_format` - The number format used to mark multiple resources - default to "%02d"

`Note`: If you specify the `vswitch_id`, the `availability_zone` would be ignore when launching ECS instances.
#### Instance Types Data Source Input Variables

- `image_name_regex` - The ECS image's name regex used to fetch latest specified system images - default to "^ubuntu_14.*_64" and it would return a latest 64bit Ubuntu Image

### Instance typs Variables

- `cpu_core_count` - CPU core count used to fetch instance types - default to 1
- `memory_size` - Memory size used to fetch instance types - default to 2

#### VSwitch Input Variables

- `vswitch_id` - VSwitch ID to launch new ECS instances

#### Security Groups Input Variables

- `group_ids` - List of Security Group IDs to launch new ECS instances

#### ECS Disk Input Variables

- `number_of_disks` - The number disks you want to launch - default to 0
- `disk_name` - ECS disk name to mark data disk(s) - default to "TF_ECS_Disk"
- `disk_category` - ECS disk category to launch data disk(s) - choices to ["cloud_ssd", "cloud_efficiency"] - default to "cloud_efficiency"
- `disk_size` - ECS disk size to launch data disk(s) - default to 40
- `disk_tags` - A map for setting ECS disk tags - default to

      disk_tags = {
          created_by = "Terraform"
          created_from = "module-tf-alicloud-ecs-instance"
      }

#### ECS Instance Input Variables

- `number_of_instances` - The number of instances you want to launch - default to 1
- `image_id` - The image id to use - default to an Ubuntu-64bit image ID retrieved by images' data source
- `instance_type` - The ECS instance type, e.g. ecs.n4.small, - default to a 1Core 2GB instance type retrieved by instance_types' data source
- `instance_name` - ECS instance name to mark instance(s) - default to "TF_ECS_Instance"
- `host_name` - ECS instance host name to configure instance(s) - default to "TF_ECS_Host_Name"
- `system_category` - ECS disk category to launch system disk - choices to ["cloud_ssd", "cloud_efficiency"] - default to "cloud_efficiency"
- `system_size` - ECS disk size to launch system disk - default to 40
- `allocate_public_ip` - Whether to allocate public for instance(s) - default to true
- `internet_charge_type` - The internet charge type for setting instance network - choices["PayByTraffic", "PayByBandwidth"] - default to "PayByTraffic"
- `internet_max_bandwidth_out` - The max out bandwidth for setting instance network - default to 10
- `instance_charge_type` - The instance charge type - choices to ["PrePaid", "PostPaid"] - default to "PostPaid"
- `period` - The instance charge period when instance charge type is 'PrePaid' - default to 1
- `key_name` - The instance key pair name for SSH keys
- `password` - The instance password
- `instance_tags` - A map for setting ECS Instance tags - default to

      instance_tags = {
          created_by = "Terraform"
          created_from = "module-tf-alicloud-ecs-instance"
      }


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

       module "tf-instances" {
          source = "github.com/terraform-community-modules/terraform-alicloud-ecs-instance"

          alicloud_access_key = "${var.alicloud_access_key}"
          alicloud_secret_key = "${var.alicloud_secret_key}"
          region = "${var.region}"

          vswitch_id = "${var.vswitch_id}"
          group_ids = "${var.group_ids}"

          disk_category = "cloud_ssd"
          disk_name = "my_module_disk"
          disk_size = "50"
          number_of_disks = 2

          instance_name = "my_module_instances"
          host_name = "my_host"
          internet_charge_type = "PayByTraffic"
          number_of_instances = "2"

          key_name = "${var.key_name}"

        }

2. Setting values for the following variables, either through terraform.tfvars or environment variables or -var arguments on the CLI

- alicloud_access_key
- alicloud_secret_key
- region
- key_name
- vswitch_id
- group_ids

Module Output Variables
-----------------------

- instance_ids - List of new instance ids
- disk_ids - List of new data disk ids

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)