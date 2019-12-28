Alicloud ECS Instance Terraform Module In VPC  
terraform-alicloud-ecs-instance
=====================================================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/blob/master/README-CN.md)

Terraform module which creates ECS instance(s) on Alibaba Cloud. 

These types of resources are supported:

* [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## Terraform versions

For Terraform 0.12 use version `v2.*` and `v1.3.0` of this module.

If you are using Terraform 0.11 you can use versions `v1.2.*`.

## Usage

```hcl
data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*_64"
}

module "ecs_cluster" {
  source  = "alibaba/ecs-instance/alicloud"
  version = "~> 2.0"

  number_of_instances = 5

  name                        = "my-ecs-cluster"
  image_id                    = data.alicloud_images.ubuntu.ids.0
  instance_type               = "ecs.sn1ne.large"
  vswitch_id                  = "vsw-fhuqie"
  security_group_ids          = ["sg-12345678"]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10

  key_name = "for-ecs-cluster"

  system_disk_category = "cloud_ssd"
  system_disk_size     = 50

  tags = {
    Created      = "Terraform"
    Environment = "dev"
  }
}
```

## Examples

* [Basic ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic)
* [ECS Instance with disk attachment example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/disk-attachment)
* [ECS Instance with EIP association example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/eip-association)
* [Bare-Metal ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/bare-metal)
* [Compute-Optimized-Type-With-Fpga ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/compute-optimized-type-with-fpga)
* [Compute-Optimized-Type-With-Gpu ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/compute-optimized-type-with-gpu)
* [Visualization-Compute-Optimized-Type-With-Gpu ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/visualization-compute-optimized-type-with-gpu)
* [Super-Computing-Cluster-Cpu ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/super-computing-cluster/cpu)
* [x86-Architecture-Big-Data ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/big-data)
* [x86-Architecture-Compute-Optimized ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/compute-optimized)
* [x86-Architecture-Entry-Level ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/entry-level)
* [x86-Architecture-General-Purpose ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/general-purpose)
* [x86-Architecture-High-Clock-Speed ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/high-clock-speed)
* [x86-Architecture-Local-Ssd ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/local-ssd)
* [x86-Architecture-Memory-Optimized ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/memory-optimized)

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.
* One of `vswitch_id` or `vswitch_ids` is required. If both are provided, the value of `vswitch_id` is prepended to the value of `vswitch_ids`.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


