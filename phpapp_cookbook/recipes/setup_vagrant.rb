include_recipe "phpapp::setup_shared"
include_recipe "phpmyadmin::default"
include_recipe "selinux::default"

phpmyadmin_db 'Dev DB' do
  host "#{node['phpapp']['rds']}"
  port 3306
  username 'root'
  password ''
  auth_type 'http'
end

selinux_state 'permissive' do
  action :permissive
end

selinux_state 'disabled' do
  action :disabled
end

bash "disable_firewall" do
  only_if "chkconfig --list | grep iptables"
  code <<-EOH
    service iptables stop
    chkconfig iptables off
  EOH
end

directory '/var/lib/php/session' do
	owner 'root'
	group 'root'
	mode 01777
	recursive true
	action :create
end

web_app "web_app" do
    docroot "#{node['phpapp']['home']}/public"
    template "webapp.dev.conf.erb"
    server_name "#{node['phpapp']['domain']}"
    server_aliases [node[:hostname], "#{node['phpapp']['domain']}"]
    notifies :reload, resources(:service => "apache2"), :delayed
end

composer_project node['phpapp']['home'] do
    dev false
    quiet true
    prefer_dist false
    prefer_source true
    optimize_autoloader true
    action :install
end