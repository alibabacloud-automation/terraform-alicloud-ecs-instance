# Gruntwork Ubuntu-Test Docker Image

The purpose of this Docker image is to provide a pre-built Ubuntu 18.04 Docker image that has most of the libraries
we would expect to be installed on the Ubuntu 18.04 AMI that would run in AWS. For example, we'd expect `curl` in AWS,
but it doesn't exist by default in Docker `ubuntu:18.04`.

### Building and Pushing a New Docker Image to Docker Hub

This Docker image should publicly accessible via Docker Hub at https://hub.docker.com/r/gruntwork/ubuntu-test/. To build and
upload it:

1. `docker build -t gruntwork/ubuntu-test:18.04 .`
1. `docker push gruntwork/ubuntu-test:18.04`

