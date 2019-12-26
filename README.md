Alicloud ECS Instance Terraform Module In VPC
terraform-alicloud-ecs-instance
=====================================================================

English | [简体中文](README-CN.md)

Terraform module which creates [ECS instances in Alicloud VPC](https://www.alibabacloud.com/help/doc-detail/25374.htm) on Alibaba Cloud. 

These types of resources are supported:

* [ECS-VPC Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

**NOTE:** This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.
**NOTE:** We have deprecated ECS instance field `io_optimized` from `terraform-provider-alicloud`. If you happened some I/O optimized issues, please download and update provider package from [terraform-provider-alicloud release](https://github.com/alibaba/terraform-provider/releases).

## Features

This module aims to implement **ALL** combinations of arguments supported by Alibaba Cloud and latest stable version of Terraform:

// todo

## Terraform versions

For Terraform 0.12 use version `v2.*` of this module.

If you are using Terraform 0.11 you can use versions `v1.*`.

## Usage

There are There are several ways to create different types of instances using this module:

// todo

## Conditional creation

// todo

## Examples

* [Basic PostPaid ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic/post-paid)
* [Basic PrePaid ECS Instance example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic/pre-paid)
* [Multi ECS Instances example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/multi-instance)
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


