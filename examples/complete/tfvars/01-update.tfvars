##############################################################
#variables for alicloud_instance
##############################################################
name = "example-with-diskser-update"
number_of_instances = 2
internet_max_bandwidth_out = 20
description = "An ECS instance came from terraform-alicloud-modules/ecs-instance-update"
internet_charge_type = "PayByBandwidth"
host_name = "tfEcsInstanceUpdate"
password = "YouPassword1234"
system_disk_size = 60
disk_name = "TF_ECS_Disk_update"
private_ip = "8.214.23.168"
instance_charge_type = "PrePaid"
subscription =  {
period             = 1
period_unit        = "Month"
renewal_status     = "Normal"
auto_renew_period  = 1
include_data_disks = true
}
dry_run = false
deletion_protection = true
force_delete = true
security_enhancement_strategy = "Deactive"
tags = {"info":"instance tag update"}
volume_tags = {"name":"volume_tags update"}