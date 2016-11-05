#!/bin/bash

echo "Installing Ansible..."
# apt-get install -y software-properties-common
# apt-add-repository ppa:ansible/ansible
apt-get update
sudo apt-get install -y --force-yes ansible python2.7
