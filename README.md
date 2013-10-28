opsworks-php55-app-layer-cookbooks
==================================

AWS OpsWorks layer with support for PHP 5.5 and php application deployment

Initial Setup
=============
1. Create a Stack with a custom cookbook pointing to `git://github.com/aporat/opsworks-php55-app-layer-cookbooks.git`
2. Add a new `App Server -> PHP Layer` layer. Note that only Amazon Linux AMI is supported. 
3. Edit the newly created layer, and add the custom recipes:

  * add phpapp::configure & mysql::client in the setup lifetime event
  * add phpapp::deploy in the deploy lifetime event

