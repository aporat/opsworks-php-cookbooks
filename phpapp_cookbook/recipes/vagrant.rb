include_recipe "phpapp::setup"

bash "disable_firewall" do
  only_if "chkconfig --list | grep iptables"
  code <<-EOH
    service iptables stop
    chkconfig iptables off
  EOH
end

include_recipe "phpmyadmin::default"

phpmyadmin_db 'Dev DB' do
  host 'localhost'
  port 3306
  username 'root'
  password ''
  auth_type 'cookie'
  hide_dbs %w{ information_schema mysql phpmyadmin performance_schema }
end

web_app "web_app" do
    docroot "/var/#{node['phpapp']['path']}/public"
    template "webapp.dev.conf.erb"
    server_name "#{node['phpapp']['domain']}"
    server_aliases [node[:hostname], "#{node['phpapp']['domain']}"]
    notifies :reload, resources(:service => "apache2"), :delayed
end

execute "apachectl restart" do
    ignore_failure true
end