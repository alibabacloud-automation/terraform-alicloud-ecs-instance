// Output the IDs of the ECS instances created
output "instance_ids" {
  value = join(",", alicloud_instance.instances.*.id)
}

// Output the IDs of the ECS disks created
output "disk_ids" {
  value = join(",", alicloud_disk.disks.*.id)
}

output "instance_name" {
  value = concat(alicloud_instance.instances.*.instance_name)[0]
}

output "instance_tags" {
  value = alicloud_instance.instances.0.tags
}

output "availability_zone" {
  value = alicloud_instance.instances.0.availability_zone
}

# VSwitch  ID
output "vswitch_id" {
  value = alicloud_instance.instances.0.vswitch_id
}

# Security Group outputs
output "group_ids" {
  value = alicloud_instance.instances.0.security_groups
}

# Key pair outputs
output "key_name" {
  value = alicloud_instance.instances.0.key_name
}

# Disk outputs

output "disk_category" {
  value = alicloud_disk.disks.0.category
}

output "disk_size" {
  value = alicloud_disk.disks.0.size
}

output "disk_tags" {
  value = alicloud_disk.disks.0.tags
}

output "number_of_disks" {
  value = length(alicloud_disk.disks)
}

# Ecs instance outputs
output "image_id" {
  value = alicloud_instance.instances.0.image_id
}

output "instance_type" {
  value = alicloud_instance.instances.0.instance_type
}

output "system_category" {
  value = alicloud_instance.instances.0.system_disk_category
}

output "system_size" {
  value = alicloud_instance.instances.0.system_disk_size
}

output "host_name" {
  value = alicloud_instance.instances.0.host_name
}

output "password" {
  value = alicloud_instance.instances.0.password
}

output "private_ips" {
  value = alicloud_instance.instances.0.private_ip
}

output "internet_charge_type" {
  value = alicloud_instance.instances.0.internet_charge_type
}

output "internet_max_bandwidth_out" {
  value = alicloud_instance.instances.0.internet_max_bandwidth_out
}

output "instance_charge_type" {
  value = alicloud_instance.instances.0.instance_charge_type
}

output "period" {
  value = alicloud_instance.instances.0.period
}

output "number_of_instances" {
  value = length(alicloud_instance.instances)
}

output "user_data" {
  value = alicloud_instance.instances.0.user_data
}


