# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "hashicorp/precise64"
  config.vm.box = "chef/centos-6.5"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  # プラグイン有効化
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["./site-cookbooks"]

    chef.add_recipe "yum-epel"
    chef.add_recipe "wordpress"
  end

end
