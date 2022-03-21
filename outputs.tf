output "this_availability_zone" {
  description = "The zone id of the instance."
  value       = alicloud_instance.this.*.availability_zone
}

# Output the IDs of the ECS instances created
output "this_instance_id" {
  description = "The instance ids."
  value       = alicloud_instance.this.*.id
}

output "this_instance_name" {
  description = "The instance names."
  value       = alicloud_instance.this.*.instance_name
}

output "this_instance_tags" {
  description = "The tags for the instance."
  value       = alicloud_instance.this.*.tags
}

# VSwitch  ID
output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = alicloud_instance.this.*.vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = alicloud_instance.this.*.security_groups
}

# Key pair outputs
output "this_key_name" {
  description = "The key name of the instance."
  value       = alicloud_instance.this.*.key_name
}

# Ecs instance outputs
output "this_image_id" {
  description = "The image ID used by the instance."
  value       = alicloud_instance.this.*.image_id
}

output "this_instance_type" {
  description = "The type of the instance."
  value       = alicloud_instance.this.*.instance_type
}

output "this_system_disk_category" {
  description = "The system disk category of the instance."
  value       = alicloud_instance.this.*.system_disk_category
}

output "this_system_disk_size" {
  description = "The system disk size of the instance."
  value       = alicloud_instance.this.*.system_disk_size
}

output "this_host_name" {
  description = "The host name of the instance."
  value       = alicloud_instance.this.*.host_name
}

output "this_private_ip" {
  description = "The private ip of the instance."
  value       = alicloud_instance.this.*.private_ip
}

output "this_public_ip" {
  description = "The public ip of the instance."
  value       = alicloud_instance.this.*.public_ip
}

output "this_internet_charge_type" {
  description = "The internet charge type of the instance."
  value       = alicloud_instance.this.*.internet_charge_type
}

output "this_internet_max_bandwidth_out" {
  description = "The internet max bandwidth out of the instance."
  value       = alicloud_instance.this.*.internet_max_bandwidth_out
}

output "this_internet_max_bandwidth_in" {
  description = "The internet max bandwidth in of the instance."
  value       = alicloud_instance.this.*.internet_max_bandwidth_in
}

output "this_instance_charge_type" {
  description = "The charge type of the instance."
  value       = alicloud_instance.this.*.instance_charge_type
}

output "this_period" {
  description = "The period of the instance."
  value       = alicloud_instance.this.*.period
}

output "this_user_data" {
  description = "The user data of the instance."
  value       = alicloud_instance.this.*.user_data
}

output "this_credit_specification" {
  description = "The credit specification of the instance."
  value       = alicloud_instance.this.*.credit_specification
}

output "this_resource_group_id" {
  description = "The resource group id of the instance."
  value       = alicloud_instance.this.*.resource_group_id
}

output "this_data_disks" {
  description = "The data disks of the instance."
  value       = alicloud_instance.this.*.data_disks
}

output "this_renewal_status" {
  description = "The renewal status of the instance."
  value       = alicloud_instance.this.*.renewal_status
}

output "this_period_unit" {
  description = "The period unit of the instance."
  value       = alicloud_instance.this.*.period_unit
}

output "this_auto_renew_period" {
  description = "The auto renew period of the instance."
  value       = alicloud_instance.this.*.auto_renew_period
}

output "this_role_name" {
  description = "The role name of the instance."
  value       = alicloud_instance.this.*.role_name
}

output "this_spot_strategy" {
  description = "The spot strategy of the instance."
  value       = alicloud_instance.this.*.spot_strategy
}

output "this_spot_price_limit" {
  description = "The spot price limit of the instance."
  value       = alicloud_instance.this.*.spot_price_limit
}

output "this_deletion_protection" {
  description = "The deletion protection setting of the instance."
  value       = alicloud_instance.this.*.deletion_protection
}

output "this_system_disk_auto_snapshot_policy_id" {
  description = "The system disk auto snapshot policy id of the instance."
  value       = alicloud_instance.this.*.system_disk_auto_snapshot_policy_id
}

output "this_security_enhancement_strategy" {
  description = "The security enhancement strategy of the instance."
  value       = alicloud_instance.this.*.security_enhancement_strategy
}

output "this_volume_tags" {
  description = "The volume tags of the instance."
  value       = alicloud_instance.this.*.volume_tags
}

output "number_of_instances" {
  description = "The number of instances."
  value       = length(alicloud_instance.this)
}

# Deprecated outputs
output "instance_ids" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_id' replaces it."
  value       = alicloud_instance.this.*.id
}

output "instance_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_name' replaces it."
  value       = concat(alicloud_instance.this.*.instance_name, [""])[0]
}

output "instance_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_tags' replaces it."
  value       = alicloud_instance.this.*.tags
}

output "availability_zone" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_availability_zone' replaces it."
  value       = alicloud_instance.this.*.availability_zone
}

# VSwitch  ID
output "vswitch_id" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_vswitch_id' replaces it."
  value       = alicloud_instance.this.*.vswitch_id
}

# Security Group outputs
output "group_ids" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_security_group_ids' replaces it."
  value       = alicloud_instance.this.*.security_groups
}

# Key pair outputs
output "key_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_key_name' replaces it."
  value       = alicloud_instance.this.*.key_name
}

# Ecs instance outputs
output "image_id" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_image_id' replaces it."
  value       = alicloud_instance.this.*.image_id
}

output "instance_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_type' replaces it."
  value       = alicloud_instance.this.*.instance_type
}

output "system_category" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_system_disk_category' replaces it."
  value       = alicloud_instance.this.*.system_disk_category
}

output "system_size" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_system_disk_size' replaces it."
  value       = alicloud_instance.this.*.system_disk_size
}

output "host_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_host_name' replaces it."
  value       = alicloud_instance.this.*.host_name
}

output "password" {
  description = "(Deprecated) It has been deprecated from version 0.1.0。 "
  value       = alicloud_instance.this.*.password
}

output "private_ips" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_private_ip' replaces it."
  value       = alicloud_instance.this.*.private_ip
}

output "internet_charge_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_internet_charge_type' replaces it."
  value       = alicloud_instance.this.*.internet_charge_type
}

output "internet_max_bandwidth_out" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_internet_max_bandwidth_out' replaces it."
  value       = alicloud_instance.this.*.internet_max_bandwidth_out
}

output "instance_charge_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_charge_type' replaces it."
  value       = alicloud_instance.this.*.instance_charge_type
}

output "period" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_period' replaces it."
  value       = alicloud_instance.this.*.period
}

output "user_data" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_user_data' replaces it."
  value       = alicloud_instance.this.*.user_data
}