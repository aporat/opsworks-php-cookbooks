# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.hostname = "webapp.dev"

  config.vm.box = "gbailey/amzn2"
 
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.network :forwarded_port, guest: 80,  host: 80
  config.vm.network :forwarded_port, guest: 443,  host: 443

  config.vm.synced_folder "app", "/var/app/", :id => "webapp-root", type: "virtualbox"

  config.vm.provision :chef_solo do |chef|
      chef.node_name = "api"
      chef.version = "12.18.31"
      chef.cookbooks_path = "resolved-cookbooks"

      chef.add_recipe "phpapp::setup_vagrant"

      chef.json = {
        :yum => {
            :exclude => 'kernel*'
        },
        :apache => {
          :listen => ['*:80', '*:443']
        },
        :phpapp => {
            :domain => 'webapp.dev'
        }
      }

  end   
     
end

