Alicloud ECS Instance Terraform Module In VPC
terraform-alicloud-ecs-instance
=====================================================================

A terraform module to provide ECS instances in Alicloud VPC. Its input variables contains VSwitch, Security Group, ECS Disks and ECS Instances.

- It assumes you have one VPC and VSwitch and you want to put the new instances to the VPC. If not, you can launch a new one by module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)
- It assumes you have several security groups in the VPC and you want to join the new instances into them. If not, you can launch one or more groups by module [terraform-alicloud-security-group](https://github.com/alibaba/terraform-alicloud-security-group)
- If you have no idea some parametes, such as instance type, availability zone and image id,
  the module will provide default values according to some input parameters, such as `available_disk_category`, `cpu_core_count`, `memory_size` and so on.

**NOTE:** This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.
**NOTE:** We have deprecated ECS instance field `io_optimized` from `terraform-provider-alicloud`. If you happened some I/O optimized issues, please download and update provider package from [terraform-provider-alicloud release](https://github.com/alibaba/terraform-provider/releases).

----------------------

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

    ```hcl
    module "tf-instances" {
        source = "alibaba/ecs-instance/alicloud"
        vswitch_id = "vsw-wqrw3c423"
        security_groups = ["sg-f2c2fwqvs"]
        private_ips = ["172.16.1.10", "172.16.1.20"]
        data_disks = [
            {
              category = "cloud_ssd"
              name     = "my_module_disk"
              size     = "50"
            },
            {
              category = "cloud_ssd"
              name     = "my_module_disk"
              size     = "60"
            }
          ]
        instance_name = "my_module_instances"
        internet_charge_type = "PayByTraffic"
        number_of_instances = "2"
        key_name = "for-ecs-instance-module"
    }
    ```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    
   
## Conditional creation

This moudle can create one or more ECS instances, it is possible to use external security groups and vswitches only if you specify `security_groups`, `vswitch_id` or `vswitch_ids` parameter, or
use filter to get these resources automatically.

1. To create ECS by specify ids:
```hcl
module "ecs-instance" {
  # omitted for brevity
  source = "alibaba/ecs-instance/alicloud"
  security_groups = ["existing-security-group-id"]
  vswitch_id = "existing-vswitch-id"
}
```

1. Retrieve the existed vswitches and security groups automatically, but not specify them ids:
```hcl
module "ecs-instance" {
  # omitted for brevity
  source = "alibaba/ecs-instance/alicloud"
  vswitch_name_regex = "my-vswitch*"
  vswitch_tags = {
    name = "ecs-module"
    from = "tf"
  }
  security_group_name_regex = "my-sg*"
  security_group_tags = {
    name = "ecs-module"
    from = "tf"
  }
}
```

1. If some resources(like vswitches, security groups and so on) have same `name_regex` or `tags`, the filter needs to be set only once:
```hcl
module "ecs-instance" {
  # omitted for brevity
  source = "alibaba/ecs-instance/alicloud"
  filter_with_name_regex = "my-ess*"
  filter_with_tags = {
    name = "ecs-module"
    from = "tf"
  }
}
```

1. you can use vpc module and security group module to create resources and set ids in this module:
```hcl
module "vpc" {
  # omitted for brevity
  source = "alibaba/vpc/alicloud"
  vpc_name = "my_terratest_vpc"
  vswitch_name = "my_terratest_vswitch"
}
module "security-group" {
  # omitted for brevity
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.vpc_id
}

module "ecs-instance" {
  # omitted for brevity
  source = "alibaba/ecs-instance/alicloud"
  vswitch_id = module.security-group.vpc_id
  security_groups = [module.security-group.security_group_id]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region  | The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile | string  | ""  | no  |
| profile  | The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable. | string  | ""  | no  |
| shared_credentials_file  | This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | string  | ""  | no  |
| skip_region_validation  | Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | bool  | false | no  |
| filter_with_name_regex  | A default filter applied to retrieve existing vswitches, security groups by name regex | string  | ""  | no  |
| filter_with_tags  | A default filter applied to retrieve existing vswitches, security groups by tags | map(string)  | {}  | no  |
| filter_with_resource_group_id  | A default filter applied to retrieve existing vswitches, security group by resource_group_id | string  | ""  | no  |
| most_recent  | If more than one images are returned, select the most recent one.  | bool  | true  | no  |
| owners  | Filter resulting iamges by a specific image owner. Valid items are `system`, `self`, `others`, `marketplace`.  | string  | "system"  | no  |
| image_name_regex  | A regex string to filter resulting images by name.   | string  | ""  | no  |
| cpu_core_count  | Filter the results to a specific number of cpu cores.  | int  | 0  | no  |
| memory_size  | Filter the results to a specific memory size in GB.  | int  | 0  | no  |
| available_disk_category  | Filter the results by a specific disk category. Can be either `cloud`, `cloud_efficiency`, `cloud_ssd`, `ephemeral_ssd`. | string  | "cloud_efficiency"  | no |
| vswitch_name_regex  | A regex string to filter vswitches by name.  | string  | ""  | no  |
| vswitch_tags  | A mapping of tags to filter vswitches by tags. | map(string)  | {} | no  |
| vswitch_resource_group_id  | A id string to filter vswitches by resource group id.  | string  | "" | no  |
| security_group_name_regex  | A regex string to filter security groups by name.  | string  | "" | no  |
| security_group_tags  | A mapping of tags to filter security groups by it.  | map(string) | {} | no  |
| security_group_resource_group_id  | A id string to filter security groups resource group id. | string  | ""  | no  |
| number_of_instances  | The number of instances to be created.  | int  | 1 | no  |
| use_num_suffix  | Always append numerical suffix to instance name, even if number_of_instances is 1 | bool  | false | no  |
| image_id  | The image id used to launch one or more ecs instances. | string  | "" | no  |
| instance_type  | The instance type used to launch one or more ecs instances.  | string  | ""  | no  |
| credit_specification  | Performance mode of the t5 burstable instance. Valid values: 'Standard', 'Unlimited'.  | string  | "Standard"  | no  |
| security_groups | A list of security group ids to associate with. | list(string) | [] | no |
| instance_name  | Name used on all instances as prefix. Like TF-ECS-Instance-1, TF-ECS-Instance-2.  | string  | "TF-ECS-Instance"  | no  |
| resource_group_id  | The Id of resource group which the instance belongs.  | string  | ""  | no  |
| internet_charge_type  | The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'.  | string  | "PayByTraffic"  | no  |
| host_name  | Host name used on all instances as prefix. Like TF-ECS-Host-Name-1, TF-ECS-Host-Name-2.  | string  | ""  | no  |
| password  | The password of instance.  | string  | ""  | no  |
| kms_encrypted_password  | An KMS encrypts password used to an instance. It is conflicted with `password`.  | string  | ""  | no  |
| kms_encryption_context  | An KMS encryption context used to decrypt `kms_encrypted_password` before creating or updating an instance with `kms_encrypted_password`  | map(string)  | {}  | no  |
| system_disk_category  | The system disk category used to launch one or more ecs instances.  | string  | "cloud_efficiency"  |  no |
| system_disk_size  | The system disk size used to launch one or more ecs instances.  | string  | "40"  |  no |
| data_disks  | Additional data disks to attach to the scaled ECS instance | list(map(string))| [] | no |
| vswitch_id  | The virtual switch ID to launch in VPC. This parameter must be set unless you can create classic network instances.  | string  | ""  | no  |
| vswitch_ids  | List of virtual switch IDs in which the ecs instances to be launched. If not set, it can be retrieved automatically by specifying filter `vswitch_name_regex` or `vswitch_tags`  | list  | []  | no  |
| private_ip  | Configure Instance private IP address | string  | ""  | no  |
| private_ips  | A list to configure Instance private IP address | list(string)  | [] | no |
| internet_max_bandwidth_in  | The maximum internet in bandwidth of instance. | int  | 200  | no |
| internet_max_bandwidth_out  | The maximum internet out bandwidth of instance. | int  | 0  | no |
| associate_public_ip_address  | Whether to associate a public ip address with an instance in a VPC. | bool  | false  | no |
| instance_charge_type  | The charge type of instance. Choices are 'PostPaid' and 'PrePaid'. | string  | "PostPaid"  | no |
| dry_run  | Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation. | string  | ""  | no |
| user_data  | User data to pass to instance on boot | string  | ""  | no |
| role_name  | Instance RAM role name. The name is provided and maintained by RAM. You can use `alicloud_ram_role` to create a new one. | string  | ""  | no  |
| key_name  | The name of key pair that can login ECS instance successfully without password. If it is specified, the password would be invalid. | string  | ""  | no  |
| spot_strategy  | The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter `instance_charge_type` is 'PostPaid'. Value range: 'NoSpot': A regular Pay-As-You-Go instance. 'SpotWithPriceLimit': A price threshold for a spot instance. 'SpotAsPriceGo': A price that is based on the highest Pay-As-You-Go instance  | string  | "NoSpot"  |  no |
| spot_price_limit  | The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'. Three decimals is allowed at most. | int  | 0  | no  |
| deletion_protection  | Whether enable the deletion protection or not. 'true': Enable deletion protection. 'false': Disable deletion protection. | bool  | false  | no  |
| force_delete  | If it is true, the 'PrePaid' instance will be change to 'PostPaid' and then deleted forcibly. However, because of changing instance charge type has CPU core count quota limitation, so strongly recommand that `Don't modify instance charge type frequentlly in one month`. | bool  | false  | no  |
| security_enhancement_strategy  | The security enhancement strategy. | string  | "Active"  | no  |
| prepaid_settings  | A mapping of fields for Prepaid ECS instances created.  | map(string)  | {"period" = "1", "period_unit" = "Month", "renewal_status" = "Normal", "auto_renew_period" = "1", "include_data_disks" = "true"}  | no  |
| tags  | A mapping of tags to assign to the resource. | map(string)  | {}  | no  |
| volume_tags  | A mapping of tags to assign to the devices created by the instance at launch time. | map(string)  | {}  | no  |

## Outputs

| Name | Description |
|------|-------------|
| this_availability_zone  | The availability zone of ECS instances  |
| this_instance_id  | The IDs of ECS instances  |
| this_instance_name  | The names of ECS instances  |
| this_instance_tags  | The tags of ECS instances  |
| this_vswitch_id  | The vswitch ids associated with the ECS instances  |
| this_key_name  | The key name associated with the ECS instances  |
| this_image_id  | The image id of ECS instances |
| this_instance_type | The instance type of ECS instances |
| this_system_disk_category | The system disk category of ECS instances |
| this_system_disk_size | The system disk size of ECS instances |
| this_host_name | The host name of ECS instances |
| this_private_ip | The private ips of ECS instances |
| this_internet_charge_type | The internet charge type of ECS instances |
| this_internet_max_bandwidth_out | The internet max bandwidth out of ECS instances |
| this_internet_max_bandwidth_in | The internet max bandwidth in of ECS instances |
| this_instance_charge_type | The instance charge type of ECS instances |
| this_period | The period of ECS instances |
| this_user_data | The user data of ECS instances |
| this_credit_specification | The credit specification of ECS instances |
| this_resource_group_id | The resource group id of ECS instances |
| this_data_disks | The data disks of ECS instances |
| this_renewal_status | The renewal status of ECS instances |
| this_period_unit | The period unit of ECS instances |
| this_auto_renew_period | The auto renew period of ECS instances |
| this_role_name | The role name of ECS instances |
| this_spot_strategy | The spot strategy of ECS instances |
| this_spot_price_limit | The spot price limit of ECS instances |
| this_deletion_protection | The deletion protection of ECS instances |
| this_security_enhancement_strategy | The security enhancement strategy of ECS instances |
| this_volume_tags | The volume tags of ECS instances |


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


