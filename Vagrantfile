# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest

  config.vm.hostname = "webapp.dev"

  config.vm.box = "centos/7"
 
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.network :forwarded_port, guest: 80,  host: 80
  config.vm.network :forwarded_port, guest: 443,  host: 443

  config.vm.synced_folder "app", "/var/webapp/", :id => "webapp-root", :nfs => true
  
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'Berksfile'

  config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "."
  
      chef.json = {
        :yum => {
            :exclude => 'kernel*'
        },
        :apache => {
          :listen => ['*:80', '*:443']
        },
        :phpapp => {
            :domain => 'webapp.dev',
            :path => 'webapp'
        }
      }
    
      chef.run_list = [
        "recipe[phpapp::setup_vagrant]"
      ]
  end   
     
end

