# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  #This is your machine for daily development, with network 10.100.100.*
  config.vm.define :dev do |dev|
    dev.vm.network "private_network", ip: "10.100.100.200"
    dev.vm.provision :shell, 
      inline: 'sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list'
    dev.vm.provision :shell, inline: 'sudo locale-gen'
    dev.vm.provision :shell, path: "bootstrap.sh"
    dev.vm.provision :shell,
      inline: 'PYTHONUNBUFFERED=1 ansible-playbook \
        /vagrant/ansible/dev.yml -c local'
  end

  #This is the mechine for alpha test enviroment. with network 10.100.168.*
  config.vm.define :alpha do |alpha|
    alpha.vm.network "private_network", ip: "10.100.168.200"
    alpha.vm.hostname = "alpha"
    alpha.vm.provision :shell, 
      inline: 'sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list'
    alpha.vm.provision :shell, inline: 'sudo locale-gen'
      
    alpha.vm.provision :shell, path: "bootstrap_alpha.sh"
    alpha.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  (1..3).each do |i|
    config.vm.define "alpha-disc-0#{i}" do |d|
      d.vm.box = "ubuntu/xenial64"
      d.vm.hostname = "alpha-disc-0#{i}"
      d.vm.network "private_network", ip: "10.100.168.6#{i}"
      d.vm.provision :shell, 
        inline: 'sudo sed -i "s/archive.ubuntu.com/mirrors.163.com/g" /etc/apt/sources.list'
      d.vm.provision :shell, inline: 'sudo locale-gen'
      
      d.vm.provision :shell, path: "bootstrap_alpha.sh"
      d.vm.provider "virtualbox" do |v|
        v.memory = 1024
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
