Description
===========

This cookbook installs PHP Composer from http://getcomposer.org.

Dependency Manager for PHP

Composer is a tool for dependency management in PHP. It allows you to 
declare the dependent libraries your project needs and it will 
install them in your project for you.

Requirements
============

Platform
--------

* Debian, Ubuntu
* CentOS, Red Hat, Fedora


Attributes
==========

None

Usage
=====

## Install Composer and run ./composer.phar install

    composer "/var/www/mysite" do
      action [:deploy, :install]
    end

License and Author
==================

Author:: Geoffrey Tran (<geoffrey.tran@gmail.com>)

Copyright:: 2012, Geoffrey Tran <http://geoffreytran.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

