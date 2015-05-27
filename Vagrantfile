# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.omnibus.chef_version = "11.10.0"

  config.vm.hostname = "webapp.dev"

  config.vm.box = "chef/centos-6.5"
 
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
        :phpapp => {
            :domain => 'webapp.dev',
            :path => 'webapp'
        }
      }
    
      chef.run_list = [
        "recipe[phpapp::vagrant]"
      ]
  end   
     
end

