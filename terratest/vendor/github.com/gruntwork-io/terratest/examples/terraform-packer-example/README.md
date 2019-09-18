# Terraform Packer Example

This folder contains a Terraform module that deploys resources in [AWS](https://aws.amazon.com/) to demonstrate
how you can use Terratest to write automated tests for your AWS Terraform code. This module deploys an [EC2
Instance](https://aws.amazon.com/ec2/) in the AWS region specified in the `aws_region` variable. The EC2 Instance runs
the AMI specified via the `ami_id` variable. It is assumed that this is an AMI built using the Packer template in
[packer-docker-example](/examples/packer-docker-example), which contains a simple Ruby web app. This module will
configure a User Data script to start the web app, configuring it to listen for HTTP requests on the port specified by
the `instance_port` variable and return the text specified by the `instance_text` variable.

Check out [test/terraform_packer_example_test.go](/test/terraform_packer_example_test.go) to see how you can write
automated tests for this module. Note that this is an end-to-end integration test that will build the AMI, deploy it
using Terraform, validate the web app is working, and then clean everything up. The test is broken down into "stages"
so that, when iterating locally, you can choose to skip any of the stages by setting an environment variable. For
example, if you've already built the AMI and don't want to rebuild it each time you re-run the test, you can set the
environment variable `SKIP_build_ami=true`.

**WARNING**: This module and the automated tests for it deploy real resources into your AWS account which can cost you
money. The resources are all part of the [AWS Free Tier](https://aws.amazon.com/free/), so if you haven't used that up,
it should be free, but you are completely responsible for all AWS charges.





## Running this module manually

1. Sign up for [AWS](https://aws.amazon.com/).
1. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Packer](https://www.packer.io/) and make sure it's on your `PATH`.
1. Follow the instructions in [packer-docker-example](/examples/packer-docker-example) to build an AMI. Note down the
   AMI ID.
1. Open `variables.tf` and set the `ami_id` variable to the ID of the AMI you just built.
1. Run `terraform init`.
1. Run `terraform apply`.
1. The `instance_url` output variable shows you the URL of the web server. Try opening it in your browser!
1. When you're done, run `terraform destroy`.




## Running automated tests against this module

1. Sign up for [AWS](https://aws.amazon.com/).
1. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Packer](https://www.packer.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
1. `cd test`
1. `dep ensure`
1. `go test -v -run TestTerraformPackerExample`
