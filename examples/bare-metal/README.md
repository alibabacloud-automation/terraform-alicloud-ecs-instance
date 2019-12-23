# Bare-Metal ECS Instance example

Configuration in this directory creates set of bare-metal ECS instance resources.

Data sources are used to discover existing vpc, vswitch and security groups.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this\_instance\_id | The ID of the ECS instance |
| this\_instance\_name | The name of the ECS instance |
| this\_instance\_type | The ECS instance type|
| this\_image\_id | The ECS instance image id|
| this\_vswitch\_id | The ID of the Vswitch |
| this\_security\_group\_ids | The ID of the Security Group  |
| this\_private\_ip | The private ip of the ECS instance |
| this\_public\_ip | The public ip of the ECS instance |
| this_instance_tags | The instance tags|
| this_availability_zone | The available zone id in which instance launched |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
