opsworks-php-cookbooks
==================================

AWS OpsWorks custom layer with support for PHP 5.6 and php application deployment. Also contains a centos 6.5 virtual machine using Vagrant that emulate Amazon Linux environment.

Please make sure to read opsworks user guide before using these cookbooks http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-chef11-10.html

Initial Stack Setup
=============

1. Add a new stack
2. Under Advanced Settings:
   - Pick chef version `11.10` as the chef version
   - Use custom cookbook pointing to `https://github.com/aporat/opsworks-php-cookbooks.git` (or fork this repo and host it yourself)
   - Enable "Manage Berkshelf" with `3.2.0` as the version
3. Add a new `App Server -> PHP Layer` layer. Note that only Amazon Linux AMI is supported. 
4. Edit the newly created layer, and add the custom recipes:
  * add phpapp::setup & mysql::client in the setup lifetime event
  * add phpapp::deploy in the deploy lifetime event
5. Add a PHP application from the "Applications" section


Vagrant Setup
=============

1. Download Vagrant 1.6+ from http://www.vagrantup.com
2. Download latest VirtualBox from https://www.virtualbox.org
3. Install ChefDK ">= 0.6.0" https://downloads.getchef.com/chef-dk/mac/#/
3. Install vagrant-omnibus `vagrant plugin install vagrant-omnibus`
4. Install vagrant-berkshelf `vagrant plugin install vagrant-berkshelf`
4. Create a new project with the supplied `Vagrantfile` and edit `chef.cookbooks_path` to point to the cookbooks folder
