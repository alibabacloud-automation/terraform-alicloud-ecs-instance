# Terraform AWS RDS Example

This folder contains a simple Terraform module that deploys a database instance (MySQL by default) in [AWS](https://aws.amazon.com/)
to demonstrate how you can use Terratest to write automated tests for your AWS Terraform code. This module deploys an [RDS
Instance](https://aws.amazon.com/rds/) and associates it with an option group and parameter group to customize it.

Check out [test/terraform_aws_rds_example_test.go](/test/terraform_aws_rds_example_test.go) to see how you can write
automated tests for this module and validate the configuration of the parameters and options.

This module does not use the database instance created in any way. It can be used though to validate any combination of inputs
passed while creating database instances in AWS RDS. Hence the plain text simple password used here should not have any security
implications.

**WARNING**: This module and the automated tests for it deploy real resources into your AWS account which can cost you
money. The resources are all part of the [AWS Free Tier](https://aws.amazon.com/rds/free/), so if you haven't used that up,
it should be free, but you are completely responsible for all AWS charges.





## Running this module manually

1. Sign up for [AWS](https://aws.amazon.com/).
1. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Set the AWS region you want to use as the environment variable `AWS_DEFAULT_REGION`.
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Run `terraform init`.
1. Run `terraform apply`.
1. When you're done, run `terraform destroy`.




## Running automated tests against this module

1. Sign up for [AWS](https://aws.amazon.com/).
1. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
1. `cd test`
1. `dep ensure`
1. `go test -v -run TestTerraformAwsRdsExample`
