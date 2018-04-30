# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  #config.vm.box = "bento/centos-7.4"
  config.vm.box = "centos-7.4.virtualbox"

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.become = true
    ansible.groups = {
     "mgmt" => ["mgmt01"],
     "meta" => ["meta01"],
     "storage" => ["storage01"],
     "clients" => ["client01"],
     "all_groups:children" => ["mgmt", "meta", "storage", "clients"]
    }
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
  end

  config.vm.define "mgmt01" do |config|
    config.vm.hostname = "mgmt01"
    config.vm.network "private_network", ip: "192.168.44.10"
  end

  config.vm.define "meta01" do |config|
    config.vm.hostname = "meta01"
    config.vm.network "private_network", ip: "192.168.44.20"
  end

  config.vm.define "storage01" do |config|
    config.vm.hostname = "storage01"
    config.vm.network "private_network", ip: "192.168.44.30"
  end

  config.vm.define "client01" do |config|
    config.vm.hostname = "client01"
    config.vm.network "private_network", ip: "192.168.44.40"
  end

end
