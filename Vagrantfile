# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.omnibus.chef_version = "11.10.0"

  config.vm.hostname = "webapp.dev"

  config.vm.box = "CentOS-6.4-x86_64-v20130731.box"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/1176031/CentOS-6.4-x86_64-v20130731.box"
  
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.network :forwarded_port, guest: 80,  host: 80

  config.vm.synced_folder "", "/var/webapp/", :id => "webapp-root", :nfs => true
     
  config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "PATH_TO_COOKBOOKS"
  
      chef.json = {
        :yum => {
            :exclude => 'kernel*'
        },
        :phpmyadmin => {
            :version => '4.1.7',
            :blowfish_secret => 'CHANGE_ME'
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

