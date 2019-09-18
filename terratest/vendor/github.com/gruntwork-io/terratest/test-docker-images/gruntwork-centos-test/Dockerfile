FROM centos/systemd:latest

# Reduce Docker image size per https://blog.replicated.com/refactoring-a-dockerfile-for-image-size/
# - perl-Digest-SHA: installs shasum
RUN yum update -y && \
    yum upgrade -y && \
    yum install -y epel-release && \
    yum install -y \
        bind-utils \
        perl-Digest-SHA \
        python-pip \
        rsyslog \
        sudo \
        vim \
        wget && \
        yum clean all && rm -rf /var/cache/yum

# Install jq. Oddly, there's no RPM for jq, so we install the binary directly. https://serverfault.com/a/768061/199943
RUN wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x ./jq && \
    cp jq /usr/bin

# Install the AWS CLI per https://docs.aws.amazon.com/cli/latest/userguide/installing.html.
RUN pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install awscli --upgrade

# Install the latest version of Docker, Consumer Edition
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum -y install docker-ce && \
    yum clean all

# We run systemd as our container process. Systemd can spawn other forks as necessary to help us simulate a real-world
# CentOS systemd environment.
CMD ["/usr/sbin/init"]

# NOTE! This Docker container should be run with the following runtime options to ensure that systemd works correctly:
# Although this bind-mounted volume would appear at first glance not to work on MacOS or Windows, because those OSs are
# running a VM to execute Docker and only a limited set of paths are mounted directly from the host, Docker is able to
# use the Linux VM's privileges to execute systemd correctly.
#
# docker run -d --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro gruntwork/centos-test
