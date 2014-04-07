opsworks-php55-app-layer-cookbooks
==================================

AWS OpsWorks custom layer with support for PHP 5.5 and php application deployment. Also contains a centos 6.4 virtual machine using Vagrant.

Initial Setup
=============
1. Create a Stack with a custom cookbook pointing to `https://github.com/aporat/opsworks-php55-app-layer-cookbooks.git` (or clone this repo and host it yourself)
2. Pick chef version `11.10` as the chef version
2. Add a new `App Server -> PHP Layer` layer. Note that only Amazon Linux AMI is supported. 
3. Edit the newly created layer, and add the custom recipes:

  * add phpapp::configure & mysql::client in the setup lifetime event
  * add phpapp::deploy in the deploy lifetime event
4. Add a PHP application from the "Applications" section
