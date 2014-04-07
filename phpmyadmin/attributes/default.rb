#
# Cookbook Name:: phpmyadmin
# Attributes:: default
#
# Copyright 2012, Panagiotis Papadomitsos
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['phpmyadmin']['version'] = '3.5.8.1'
default['phpmyadmin']['checksum'] = '9768b9c429e6b99dcbe55b61fac4d28a8cdb18427b3f6ad30b15a93cc2173fb5'
default['phpmyadmin']['mirror'] = 'http://netcologne.dl.sourceforge.net/project/phpmyadmin/phpMyAdmin'

default['phpmyadmin']['fpm'] = true

default['phpmyadmin']['home'] = '/opt/phpmyadmin'
default['phpmyadmin']['user'] = 'phpmyadmin'
default['phpmyadmin']['group'] = 'phpmyadmin'
default['phpmyadmin']['socket'] = '/tmp/phpmyadmin.sock'

case node['platform']
when 'ubuntu', 'debian'
	default['phpmyadmin']['upload_dir'] = '/var/lib/php5/uploads'
	default['phpmyadmin']['save_dir'] = '/var/lib/php5/uploads'
when 'centos', 'redhat'
	default['phpmyadmin']['upload_dir'] = '/var/lib/php/uploads'
	default['phpmyadmin']['save_dir'] = '/var/lib/php/uploads'
end	
default['phpmyadmin']['maxrows'] = 100
default['phpmyadmin']['protect_binary'] = 'blob'
default['phpmyadmin']['default_lang'] = 'en'
default['phpmyadmin']['default_display'] = 'horizontal'
default['phpmyadmin']['query_history'] = true
default['phpmyadmin']['query_history_size'] = 100
