## 2.13.0 (unreleased)
## 2.12.0 (August 8, 2024)

- Module/alicloud_instance: supported the system_disk_name, system_disk_description, system_disk_performance_level attribute [GH-62](https://github.com/alibabacloud-automation/terraform-alicloud-ecs-instance/pull/62)


## 2.11.0 (May 7, 2024)

IMPROVEMENTS: 

- resource/alicloud_instance: add hpc_cluster_id; improve examples [GH-58](https://github.com/alibabacloud-automation/terraform-alicloud-ecs-instance/pull/58)

## 2.10.0 (July 7, 2022)

IMPROVEMENTS: 

- Add support for new parameter `operator_type` and `status`. [GH-57](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/57)

## 2.9.0 (May 12, 2022)

IMPROVEMENTS: 

- Improves the module examples/complete [GH-55](https://github.com/alibabacloud-automation/terraform-alicloud-ecs-instance/pull/55)


## 2.8.0 (December 23, 2021)

IMPROVEMENTS: 

- Removes the provider setting and improves the Readme [GH-53](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/53)
- Modified author contact information [GH-51](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/51)

## 2.7.0 (May 18, 2020)

IMPROVEMENTS:

- image_ids has wrong type [GH-47](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/47)
- supported auto snapshot policy fields [GH-46](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/46)

## 2.6.0 (February 29, 2020)

BUG FIXES:

- fix subscription checking and add variable description [GH-45](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/45)

## 2.5.1 (February 24, 2020)

IMPROVEMENTS:

- add profile for readme and examples [GH-44](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/44)

## 2.5.0 (February 20, 2020)

BUG FIXES:

- remove internet_max_bandwidth_in default to fix diff bug [GH-43](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/43)

## 2.4.0 (February 14, 2020)

IMPROVEMENTS:

- improve readme [GH-42](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/42)
- support multi images and remove provider version [GH-41](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/41)

## 2.3.0 (January 17, 2020)

BUG FIXES:

- fix(ecs): fixed bug where host name must be set. [GH-39](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/39)

## 2.2.1 (January 7, 2020)

BUG FIXES:

- fix host_name default value when use_num_suffix is false [GH-38](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/38)

## 2.2.0 (January 7, 2020)

IMPROVEMENTS:

- use_num_suffix applied to host_name [GH-37](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/37)
- change host_name and instance_name suffix using three numbers [GH-36](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/36)

## 2.1.0 (January 6, 2020)

IMPROVEMENTS:

- compatible the deprecated parameter `group_ids` [GH-35](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/35)
- host_name supports suffix [GH-35](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/35)
- change image regex [GH-35](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/35)

## 2.0.0 (December 28, 2019)

- **Added:** `examples` [GH-24](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/24)
- **Added:** `examples` [GH-28](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/28)

IMPROVEMENTS:

- deprecated `instance_name` and add `name` instead [GH-34](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/34)
- improve readme and basic examples [GH-33](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/33)
- improve(ecs): updated README.md and added chinese version. [GH-32](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/32)
- improve(ecs): added submodules and examples. [GH-31](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/31)
- add modules and improve bare-metal [GH-30](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/30)
- improve(ecs): modified the ecs module outputs. [GH-23](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/23)
- improve(ecs): added provider settings. [GH-22](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-instance/pull/22)
