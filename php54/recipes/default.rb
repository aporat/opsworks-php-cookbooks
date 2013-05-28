#
# Author:: Adar Porat(<adar.porat@gmail.com>)
# Cookbook Name:: php54
# Attribute:: default
##
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

case node['platform_family']

  when "amazon"
  node.set['php']['packages'] = ['php54', 'php54-devel', 'php54-cli', 'php54-snmp', 'php54-soap', 'php54-xml', 'php54-xmlrpc', 'php54-process', 'php54-mysql', 'php54-pdo', 'php54-gd', 'php54-imap', 'php54-mbstring']
  node.set['mysql']['server']['packages'] = %w{mysql55-server}
  node.set['mysql']['client']['packages'] = %w{mysql55}
  
  when "rhel", "fedora", "suse"
  # add the webtatic repository
  yum_repository "webtatic" do
    repo_name "webtatic"
    description "webtatic Stable repo"
    url "http://repo.webtatic.com/yum/el6/x86_64/"
    key "RPM-GPG-KEY-webtatic-andy"
    action :add
  end

  yum_key "RPM-GPG-KEY-webtatic-andy" do
    url "http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy"
    action :add
  end
  
  node.set['php']['packages'] = ['php54w', 'php54w-devel', 'php54w-cli', 'php54w-snmp', 'php54w-soap', 'php54w-xml', 'php54w-xmlrpc', 'php54w-process', 'php54w-mysql55', 'php54w-pecl-memcache', 'php54w-pecl-apc', 'php54w-pear', 'php54w-pdo', 'php54w-gd', 'php54w-imap', 'php54w-mbstring']
  node.set['mysql']['server']['packages'] = %w{mysql55-server}
  node.set['mysql']['client']['packages'] = %w{mysql55}
  
  when "debian"
    include_recipe "apt"
	apt_repository "dotdeb-php54" do
		uri "#{node['php54']['dotdeb']['uri']}"
		distribution "#{node['php54']['dotdeb']['distribution']}-php54"
		components ['all']
		key "http://www.dotdeb.org/dotdeb.gpg"
		action :add
	end
end

include_recipe 'php'