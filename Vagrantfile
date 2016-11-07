# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.ssh.username = "ubuntu"

  config.vm.provision :shell, 
      inline: 'sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list'
  config.vm.provision :shell, inline: "sudo apt-get update && sudo apt-get install python -y"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  #This is your machine for daily development, with network 10.100.80.*. 
  #the netmask support 16 networks, 0, 16, 32, 48, 64, 80, 96, 112, 128, 144,160, 176, 192, 208, 224, 240
  config.vm.define :dev do |dev|
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      dev.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
    else
      dev.vm.synced_folder ".", "/vagrant"
    end

    dev.vm.network "private_network", ip: "10.100.80.200", netmask: "255.255.240.0"
    dev.vm.hostname = "dev"
    
    dev.vm.provision :shell, path: "bootstrap.sh"
    dev.vm.provision :shell,
      inline: 'PYTHONUNBUFFERED=1 ansible-playbook \
        /vagrant/ansible/dev.yml -c local'
    dev.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  #This is the machine for alpha test enviroment. with network 10.100.81.*
  config.vm.define :jumper do |jumper|
    jumper.vm.network "private_network", ip: "10.100.81.60", netmask: "255.255.240.0"
    jumper.vm.hostname = "jumper"
    
    #jumper.vm.provision :shell, inline: "sudo locale-gen"
    jumper.vm.provision :shell, path: "bootstrap_alpha.sh"
    jumper.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  (1..3).each do |i|
    config.vm.define "alpha-disc-0#{i}" do |d|
      d.vm.hostname = "alpha-disc-0#{i}"
      d.vm.network "private_network", ip: "10.100.82.6#{i}", netmask: "255.255.240.0"
      #d.vm.provision :shell, 
      #  inline: 'sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list'
      #d.vm.provision :shell, path: "bootstrap_alpha.sh"
      d.vm.provider "virtualbox" do |v|
        v.memory = 256
      end
    end
  end

  config.vm.define "proxy" do |d|
    d.vm.hostname = "proxy"
    d.vm.network "private_network", ip: "10.100.83.200", netmask: "255.255.240.0"
    d.vm.provider "virtualbox" do |v|
      v.memory = 256
    end
  end

  #This is the mechine for alpha test enviroment. with network 10.100.82.*
  config.vm.define "swarm-master" do |d|
    d.vm.hostname = "swarm-master"
    d.vm.network "private_network", ip: "10.100.82.80", netmask: "255.255.240.0"
    d.vm.provider "virtualbox" do |v|
      v.memory = 256
    end
  end
  (1..2).each do |i|
    config.vm.define "swarm-node-#{i}" do |d|
      d.vm.hostname = "swarm-node-#{i}"
      d.vm.network "private_network", ip: "10.100.82.8#{i}", netmask: "255.255.240.0" 
      d.vm.provider "virtualbox" do |v|
        v.memory = 256
      end
    end
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
