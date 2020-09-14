opsworks-php-cookbooks
==================================

AWS OpsWorks custom layer with support for PHP 7.4 and php application deployment from a private git repository. 
The project also contains an Amazon Linux virtual machine using Vagrant that emulate Amazon Linux AMI environment.

Please make sure to read opsworks user guide before using these cookbooks http://docs.aws.amazon.com/opsworks/latest/userguide/chef-12-linux.html

Based on https://www.chef.io/blog/2015/12/07/chef-community-cookbooks-with-aws-opsworks-chef-12/

Requirements
============
- Chef Development Kit (chefdk)
- AWS CLI
- S3 bucket for chef cookbooks deployment
- Vagrant

Bundling up the Cookbook for OpsWorks
=============
1. Download or clone this repository
2. Run `berks package cookbooks.tar.gz` to bundle the cookbooks
3. Upload cookbooks bundle to S3 `aws s3 cp cookbooks.tar.gz s3://YOURBUCKET/cookbooks.tar.gz`


Stack Setup
=============

1. Add a new stack (Chef 12 Stack)
2. Use latest Amazon Linux AMI
2. Under Advanced Settings:
   - Pick `Use custom Chef cookbooks`
   - Repository type: `S3 Archive`
   - Repository URL `s3://YOURBUCKET/cookbooks.tar.gz`
   - Enter S3 credentials if your cookbooks are not public
3. Add a new layer. 
4. Edit the newly created layer, and add the custom chef recipes:
  * add phpapp::setup_opsworks to the setup lifetime event
  * add phpapp::deploy_opsworks to the deploy lifetime event
5. If your VPC is public, make sure the Automatically `Assign Public IP Address` in the layer's network settings is turned on
5. Add an application from the "Applications" section. Make sure to enter your git deploy key


Vagrant Setup
=============

1. Download Vagrant 1.6+ from http://www.vagrantup.com
2. Download the latest VirtualBox from https://www.virtualbox.org
3. Install ChefDK ">= 0.6.0" https://downloads.getchef.com/chef-dk/mac/#/
3. Install vagrant-omnibus `vagrant plugin install vagrant-omnibus`
4. Install vagrant-berkshelf `vagrant plugin install vagrant-berkshelf`
4. Create a new project with the supplied `Vagrantfile` and edit `chef.cookbooks_path` to point to the cookbooks folder
