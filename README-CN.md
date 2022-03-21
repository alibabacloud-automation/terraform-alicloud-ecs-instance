terraform-alicloud-ecs-instance
=====================================================================

本 Module 用于在阿里云的 VPC 下创建一个[云服务器ECS实例（ECS Instance）](https://www.alibabacloud.com/help/zh/doc-detail/25374.htm). 

本 Module 支持创建以下资源:

* [云服务器ECS实例（ECS Instance）](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## 用法

```hcl
data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
}

module "ecs_cluster" {
  source  = "alibaba/ecs-instance/alicloud"

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
本Module从版本v2.8.0开始已经移除掉如下的 provider 的显式设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-instance"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 2.7.0:

```hcl
module "ecs_cluster" {
  source              = "alibaba/ecs-instance/alicloud"
  version             = "2.7.0"
  region              = "cn-beijing"
  profile             = "Your-Profile-Name"
  number_of_instances = 5
  name                = "my-ecs-cluster"
  // ...
}
```

如果你想对正在使用中的Module升级到 2.8.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "ecs_cluster" {
  source              = "alibaba/ecs-instance/alicloud"
  number_of_instances = 5
  name                = "my-ecs-cluster"
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "ecs_cluster" {
  source              = "alibaba/ecs-instance/alicloud"
  providers = {
    alicloud = alicloud.bj
  }
  number_of_instances = 5
  name                = "my-ecs-cluster"
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

提交问题
------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)