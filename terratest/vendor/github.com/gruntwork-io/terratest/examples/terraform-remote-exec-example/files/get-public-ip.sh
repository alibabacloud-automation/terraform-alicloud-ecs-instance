#!/bin/bash

# For example purposes, print the public IP address of this instance
wget -q -O- http://169.254.169.254/latest/meta-data/public-ipv4

