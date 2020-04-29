Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"
# YAML module for reading box configurations.
require 'yaml'
#  server configs from YAML/YML file

servers_list = YAML.load_file(File.join(File.dirname(__FILE__), 'provisioning/servers_list.yml'))
# servers_list = YAML.load_file(File.join(File.dirname(__FILE__), 'servers_list.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 # Disable updates
 config.vm.box_check_update = false

      servers_list.each do |server|
        config.vm.define server["vagrant_box_host"] do |box|
          box.vm.box = server["vagrant_box"]
          box.vm.hostname = server["vagrant_box_host"]
          box.vm.network server["network_type"], ip: server["vagrant_box_ip"]
          # box.vm.network "forwarded_port", guest: server["guest_port"], host: server["host_port"]
          box.vm.provider "virtualbox" do |vb|
              vb.name = server["vbox_name"]
              vb.memory = server["vbox_ram"]
              vb.cpus = server["vbox_cpu"]
              vb.gui = false
              vb.customize ["modifyvm", :id, "--groups", "/beegfs-sandbox"] # create vbox group
          end # end of box.vm.providers

          box.vm.provision "ansible_local" do |ansible|
              # ansible.compatibility_mode = "2.0"
              ansible.compatibility_mode = server["ansible_compatibility_mode"]
              ansible.version = server["ansible_version"]
              ansible.playbook = server["server_bootstrap"]
              ansible.inventory_path = 'provisioning/inventory_localconn'
              # ansible.inventory_path = 'inventory'
              # ansible.verbose = "vvvv" # debug
              # ansible.groups = {
              #  "vgmgmt" => ["vg-mgmt01"],
              #  "vgmeta" => ["vg-meta01"],
              #  "vgstorage" => ["vg-storage01","vg-storage02"],
              #  "vgclients" => ["vg-client01","vg-client02"],
              #  "vgmons" => ["vg-admon01"],
              #  "all_groups:children" => ["vgmgmt", "vgmeta", "vgstorage", "vgclients","vgmons"]
              # }
              # ansible.inventory_path = 'provisioning/hosts'
              # ansible.verbose = "vvvv" # debug
           end # end if box.vm.provision
          box.vm.provision "shell", inline: <<-SHELL
          echo "===================================================================================="
                                    hostnamectl status
          echo "===================================================================================="
          echo "         \   ^__^                                                                  "
          echo "          \  (oo)\_______                                                          "
          echo "             (__)\       )\/\                                                      "
          echo "                 ||----w |                                                         "
          echo "                 ||     ||                                                         "
          SHELL

        end # end of config.vm
      end  # end of servers_list.each loop
end # end of Vagrant.configure
