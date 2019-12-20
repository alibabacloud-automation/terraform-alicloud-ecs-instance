# Complete ECS Instance example

Configuration in this directory creates set of ECS instance resource in various combinations.

Data sources are used to discover existing instance type.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this\_instance\_id | The ID of the ECS instance |
| this\_instance\_name | The name of the ECS instance |
| this\_vswitch\_id | The ID of the Vswitch |
| this\_security\_group\_ids | The ID of the Security Group  |
| this\_private\_ip | The private ip of the ECS instance |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
