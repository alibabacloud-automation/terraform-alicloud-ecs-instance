# Terraform AWS S3 Example

This folder contains a simple Terraform module that deploys resources in [AWS](https://aws.amazon.com/) to demonstrate
how you can use Terratest to write automated tests for your AWS Terraform code. This module deploys an [S3
Bucket](https://aws.amazon.com/s3/) and gives that Bucket a `Name` & `Environment` tag with the value specified in the
`tag_bucket_name` and `tag_bucket_environment` variables, respectively.  This module also contains a terraform variable 
that will create a basic bucket policy that will restrict the bucket to only accept SSL connections.

Check out [test/terraform_aws_s3_example_test.go](/test/terraform_aws_s3_example_test.go) to see how you can write
automated tests for this module.

Note that the S3 Bucket in this module will not contain any actual objects/files after creation; it will only contain a 
versioning configuration, as well as tags. For slightly more complicated, real-world examples of Terraform modules (with 
other AWS services), see [terraform-http-example](/examples/terraform-http-example) and 
[terraform-ssh-example](/examples/terraform-ssh-example).

**WARNING**: This module and the automated tests for it deploy real resources into your AWS account which can cost you
money. The resources are all part of the [AWS Free Tier](https://aws.amazon.com/free/), so if you haven't used that up,
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
1. `go test -v -run TestTerraformAwsS3Example`
