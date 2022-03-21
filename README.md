Alicloud ECS Instance Terraform Module In VPC  
terraform-alicloud-ecs-instance

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/blob/master/README-CN.md)

Terraform module which creates ECS instance(s) on Alibaba Cloud. 

These types of resources are supported:

* [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)

## Usage

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
From the version v2.8.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ecs-instance"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 2.7.0:

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

If you want to upgrade the module to 2.8.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)