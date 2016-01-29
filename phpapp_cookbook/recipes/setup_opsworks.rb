node.set['apache']['version'] = '2.4'
node.set['apache']['package'] = 'httpd24'

include_recipe "phpapp::setup_shared"

app = search(:aws_opsworks_app).first

# set any php.ini settings needed
template "/etc/php.d/app.ini" do
  source "php.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

# set apache2 hosts
web_app "#{app['name']}" do
  server_name "api.#{app['shortname']}.com"
  docroot "/var/app/public"
  template "webapp.#{app['shortname']}.conf.erb"
end