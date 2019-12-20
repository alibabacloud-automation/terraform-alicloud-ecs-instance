output "this_availability_zone" {
  value = local.zone_id
}

// Output the IDs of the ECS instances created
output "this_instance_id" {
  value = alicloud_instance.this.*.id
}

output "this_instance_name" {
  value = alicloud_instance.this.*.instance_name
}

output "this_instance_tags" {
  value = alicloud_instance.this.0.tags
}

# VSwitch  ID
output "this_vswitch_id" {
  value = alicloud_instance.this.*.vswitch_id
}

# Security Group outputs
output "this_security_group_ids" {
  value = alicloud_instance.this.*.security_groups
}

# Key pair outputs
output "this_key_name" {
  value = alicloud_instance.this.0.key_name
}

# Ecs instance outputs
output "this_image_id" {
  value = alicloud_instance.this.0.image_id
}

output "this_instance_type" {
  value = alicloud_instance.this.0.instance_type
}

output "this_system_disk_category" {
  value = alicloud_instance.this.0.system_disk_category
}

output "this_system_disk_size" {
  value = alicloud_instance.this.0.system_disk_size
}

output "this_host_name" {
  value = alicloud_instance.this.0.host_name
}

output "this_private_ip" {
  value = alicloud_instance.this.*.private_ip
}

output "this_internet_charge_type" {
  value = alicloud_instance.this.0.internet_charge_type
}

output "this_internet_max_bandwidth_out" {
  value = alicloud_instance.this.0.internet_max_bandwidth_out
}

output "this_internet_max_bandwidth_in" {
  value = alicloud_instance.this.0.internet_max_bandwidth_in
}

output "this_instance_charge_type" {
  value = alicloud_instance.this.0.instance_charge_type
}

output "this_period" {
  value = alicloud_instance.this.0.period
}

output "this_user_data" {
  value = alicloud_instance.this.0.user_data
}

output "this_credit_specification" {
  value = alicloud_instance.this.0.credit_specification
}

output "this_resource_group_id" {
  value = alicloud_instance.this.0.resource_group_id
}

output "this_data_disks" {
  value = alicloud_instance.this.0.data_disks
}

output "this_renewal_status" {
  value = alicloud_instance.this.0.renewal_status
}

output "this_period_unit" {
  value = alicloud_instance.this.0.period_unit
}

output "this_auto_renew_period" {
  value = alicloud_instance.this.0.auto_renew_period
}

output "this_role_name" {
  value = alicloud_instance.this.0.role_name
}

output "this_spot_strategy" {
  value = alicloud_instance.this.0.spot_strategy
}

output "this_spot_price_limit" {
  value = alicloud_instance.this.0.spot_price_limit
}

output "this_deletion_protection" {
  value = alicloud_instance.this.0.deletion_protection
}

output "this_security_enhancement_strategy" {
  value = alicloud_instance.this.0.security_enhancement_strategy
}

output "this_volume_tags" {
  value = alicloud_instance.this.0.volume_tags
}

output "number_of_instances" {
  value = length(alicloud_instance.this)
}

// Deprecated outputs
output "instance_ids" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_id' replaces it."
  value       = alicloud_instance.this.*.id
}

output "instance_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_name' replaces it."
  value       = concat(alicloud_instance.this.*.instance_name)[0]
}

output "instance_tags" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_tags' replaces it."
  value       = alicloud_instance.this.0.tags
}

output "availability_zone" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_availability_zone' replaces it."
  value       = alicloud_instance.this.0.availability_zone
}

# VSwitch  ID
output "vswitch_id" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_vswitch_id' replaces it."
  value       = alicloud_instance.this.0.vswitch_id
}

# Security Group outputs
output "group_ids" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_security_group_ids' replaces it."
  value       = alicloud_instance.this.0.security_groups
}

# Key pair outputs
output "key_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_key_name' replaces it."
  value       = alicloud_instance.this.0.key_name
}

# Ecs instance outputs
output "image_id" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_image_id' replaces it."
  value       = alicloud_instance.this.0.image_id
}

output "instance_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_type' replaces it."
  value       = alicloud_instance.this.0.instance_type
}

output "system_category" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_system_disk_category' replaces it."
  value       = alicloud_instance.this.0.system_disk_category
}

output "system_size" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_system_disk_size' replaces it."
  value       = alicloud_instance.this.0.system_disk_size
}

output "host_name" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_host_name' replaces it."
  value       = alicloud_instance.this.0.host_name
}

output "password" {
  description = "(Deprecated) It has been deprecated from version 0.1.0。 "
  value       = alicloud_instance.this.0.password
}

output "private_ips" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_private_ip' replaces it."
  value       = alicloud_instance.this.0.private_ip
}

output "internet_charge_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_internet_charge_type' replaces it."
  value       = alicloud_instance.this.0.internet_charge_type
}

output "internet_max_bandwidth_out" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_internet_max_bandwidth_out' replaces it."
  value       = alicloud_instance.this.0.internet_max_bandwidth_out
}

output "instance_charge_type" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_instance_charge_type' replaces it."
  value       = alicloud_instance.this.0.instance_charge_type
}

output "period" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_period' replaces it."
  value       = alicloud_instance.this.0.period
}

output "user_data" {
  description = "(Deprecated) It has been deprecated from version 0.1.0 and the field 'this_user_data' replaces it."
  value       = alicloud_instance.this.0.user_data
}


