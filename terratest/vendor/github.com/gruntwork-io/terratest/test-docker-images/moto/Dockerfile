FROM ubuntu:16.04

# Reduce Docker image size per https://blog.replicated.com/refactoring-a-dockerfile-for-image-size/
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y \
    python-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install --upgrade flask && \
    pip install --upgrade pyOpenSSL && \
    pip install --upgrade moto