#!/bin/bash

echo "Installing Python..."
# apt-get install -y software-properties-common
# apt-add-repository ppa:ansible/ansible
apt-get update
sudo apt-get install -y --force-yes python
