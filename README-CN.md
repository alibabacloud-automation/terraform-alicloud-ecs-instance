Alicloud ECS Instance Terraform Module In VPC
terraform-alicloud-ecs-instance
=====================================================================


本 Module 用于在阿里云的 VPC 下创建一个[云服务器ECS实例（ECS Instance）](https://www.alibabacloud.com/help/zh/doc-detail/25374.htm). 

本 Module 支持创建以下资源:

* [云服务器ECS实例（ECS Instance）](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

**注意:** 本 Module 使用的 AccessKey 和 SecretKey 取自于 `profile` 和 `shared_credentials_file`。
如果您尚未，请下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.
**注意:** 本 Module 包含已弃用字段 `io_optimized`， 如果您出现了 I/O 优化相关问题, 请下载或将 provider 更至最新版本 [terraform-provider-alicloud release](https://github.com/alibaba/terraform-provider/releases).

## 功能

本模块在稳定的 Terraform 及 阿里云 Provider 版本下，支持通过多种参数的不同组合实现对 ECS 实例的创建：

// todo

## Terraform 版本

如果您正在使用 Terraform 0.12，请使用此模块的对应版本`v2.*`.

如果您正在使用 Terraform 0.11，请使用此模块的对应版本`v1.*`.

## 用法

本 Module 支持以下几种方式来创建不同规格的 ECS 实例:

// todo

## 条件判断

// todo

## 示例

* [后付费 ECS 基础实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic/post-paid)
* [预付费 ECS 基础实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic/pre-paid)
* [ECS 实例多重创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/multi-instance)
* [弹性裸金属服务器（神龙）实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/bare-metal)
* [异构计算 FPGA 计算型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/compute-optimized-type-with-fpga)
* [异构计算 GPU 计算型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/compute-optimized-type-with-gpu)
* [异构计算 GPU 虚拟化型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/heterogeneous-computing/visualization-compute-optimized-type-with-gpu)
* [超级计算集群 CPU 型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/super-computing-cluster/cpu)
* [x86计算大数据型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/big-data)
* [x86计算优化计算型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/compute-optimized)
* [x86计算入门级（共享）型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/entry-level)
* [x86计算通用型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/general-purpose)
* [x86计算高主频型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/high-clock-speed)
* [x86计算本地 SSD 型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/local-ssd)
* [x86计算内存型实例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/x86-architecture/memory-optimized)

作者
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


