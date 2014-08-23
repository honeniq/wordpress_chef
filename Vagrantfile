# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "hashicorp/precise64"
  config.vm.box = "chef/centos-6.5"

  config.vm.network "forwarded_port", guest: 80, host: 8081
  
  # プラグイン有効化
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  
  config.vm.provision "chef_solo" do |chef|
    chef.run_list = [
        "recipe[apache2]",
        "recipe[apache2::mod_ssl]",
        "recipe[apache2::mod_rewrite]",
    ]
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  end

end
