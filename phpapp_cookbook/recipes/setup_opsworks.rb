include_recipe "phpapp::setup_shared"

app = search(:aws_opsworks_app).first

# set apache2 hosts
web_app "#{app['name']}" do
  server_name "api.#{app['shortname']}.com"
  docroot "#{node['phpapp']['home']}/public"
  template "webapp.#{app['shortname']}.conf.erb"
end