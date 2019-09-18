# Gruntwork Terratest Docker Images

As part of writing [Unit Tests with Terratest](/README.md#unit-tests), we recommend using [Packer](https://packer.io) to
build a Docker image using the same script [provisioners](https://www.packer.io/docs/templates/provisioners.html) that
Packer uses to configure the Amazon Machine Image you would normally build for production usage. Docker images build 10x
faster than AMIs and launch 100x faster, reducing our cycle time while developing.

But Packer's Docker image builds can still be slower than desired because, unlike a native `docker build` command against
a `Dockerfile`, Packer does not use any [image caching](https://docs.docker.com/v17.09/engine/userguide/eng-image/dockerfile_best-practices/).
As a result, each `packer build` creates the Docker image from scratch. Unfortunately, much of the Docker image build
time is spent downloading libraries like `curl` and `sudo` which we assume are present on the AWS AMI associated with
Ubuntu, Amazon Linux, CentOS, or any other Linux distro we're supporting.

We solve this problem by creating canonical Gruntwork Terratest Docker Images which have most of the desired libraries
pre-installed. We upload these images to a public Docker Hub repo such as https://hub.docker.com/r/gruntwork/ubuntu-test/ so
that Packer templates that build Docker images can reference them directly as in the following example.

### Sample Packer Builder

```json
{
  "builders": [{
    "name": "ubuntu-ami",
    "type": "amazon-ebs"
    // ... (other params omitted) ...
  },{
    "name": "ubuntu-docker",
    "type": "docker",
    "image": "gruntwork/ubuntu-test:18.04",
    "commit": "true"
  }],
  "provisioners": [
    // ...
  ],
  "post-processors": [{
    "type": "docker-tag",
    "repository": "gruntwork/example",
    "tag": "latest",
    "only": ["ubuntu-docker"]
  }]
}
```
