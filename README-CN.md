terraform-alicloud-ecs-instance
=====================================================================


本 Module 用于在阿里云的 VPC 下创建一个[云服务器ECS实例（ECS Instance）](https://www.alibabacloud.com/help/zh/doc-detail/25374.htm). 

本 Module 支持创建以下资源:

* [云服务器ECS实例（ECS Instance）](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## Terraform 版本

如果您正在使用 Terraform 0.12，请使用此模块的`v2.*` and `v1.3.0` 版本。

如果您正在使用 Terraform 0.11，请使用此模块的`v1.2.*` 版本.

## 用法

```hcl
data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

module "ecs_cluster" {
  source  = "alibaba/ecs-instance/alicloud"
  version = "~> 2.0"

  number_of_instances = 5

  name                        = "my-ecs-cluster"
  use_num_suffix              = true
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

## 示例

* [ECS 实例完整创建示例创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/basic)
* [ECS 实例与磁盘绑定示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/disk-attachment)
* [多台 ECS 实例与多个EIP绑定](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/tree/master/examples/eip-association)
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

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.
* 本 Module 用创建 VPC 实例，`vswitch_id` 和 `vswitch_ids` 至少要设置一个。如果两个都设置了，`vswitch_id` 将会优先于 `vswitch_ids` 被使用。

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


