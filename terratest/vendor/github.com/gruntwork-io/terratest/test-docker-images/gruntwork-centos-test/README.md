# Gruntwork CentOS-Test Docker Image

The purpose of this Docker image is to provide a pre-built CentOS 7 Docker image that has most of the libraries
we would expect to be installed on the CentOS 7 AMI that would run in AWS. For example, we'd expect `sudo` in AWS, but it
doesn't exist by default in Docker `centos:7`. It also aims to allow [systemd](https://www.freedesktop.org/wiki/Software/systemd/)
to run, which, in turn, allows you to run one or more services as [systemd units](https://www.freedesktop.org/software/systemd/man/systemd.unit.html).

### Building and Pushing a New Docker Image to Docker Hub

This Docker image should publicly accessible via Docker Hub at https://hub.docker.com/r/gruntwork/centos-test/. To build and
upload it:

1. `docker build -t gruntwork/centos-test:7 .`
1. `docker push gruntwork/centos-test:7`

### Running this Docker Image

Running systemd require elevated privileges for the Docker container, so you should run this Docker image with at least
the following options:

```
docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro gruntwork/zookeeper-centos-test:latest
```

Note that:

- We do not specify a run command like `/bin/bash` because we need to retain the Docker Image's default run command of
  `/usr/sbin/init`. This makes systemd Process ID 1, which allows it to spawn an arbitrary number of other services
- You can then connect to the Docker container with `docker exec -it <container-id> /bin/bash`.
- The container must be `--privileged` because it needs to break out of the typical [cgroups](
  https://docs.docker.com/engine/docker-overview/#the-underlying-technology) to run an init system like systemd.
- You must "hook in" to a Linux host's cgroups to allow each service to run in its own cgroup. This works even on Docker
  for Mac and Docker for Windows because those systems still use a Linux VM to run the Docker engine and do not expose
  the entire host system (e.g. your Mac laptop) for docker volume mounting.


