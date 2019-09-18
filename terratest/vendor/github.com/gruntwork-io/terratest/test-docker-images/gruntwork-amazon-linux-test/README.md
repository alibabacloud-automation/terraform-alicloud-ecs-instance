# Gruntwork Amazon-Linux-Test Docker Image

The purpose of this Docker image is to provide a pre-built Amazon Linux Docker image that has most of the libraries
we would expect to be installed on the Amazon Linux AMI that would run in AWS. For example, we'd expect `sudo` in AWS,
but it doesn't exist by default in Docker `amazonlinux:latest`.

### Building and Pushing a New Docker Image to Docker Hub

This Docker image should publicly accessible via Docker Hub at https://hub.docker.com/r/gruntwork/amazonlinux-test/. To build and
upload it:

1. `docker build -t gruntwork/amazon-linux-test:2017.12 .`
1. `docker push gruntwork/amazon-linux-test:2017.12`

