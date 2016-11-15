#!/bin/bash

echo "Update Apt source"
sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list

echo "Installing Python..."
sudo rm -rf "/var/lib/apt/lists/*" "/var/cache/apt/archives/partial/*"
sudo apt-get update && sudo apt-get install -y --force-yes python
