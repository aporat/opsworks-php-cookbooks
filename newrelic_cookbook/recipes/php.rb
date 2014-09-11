include_recipe "newrelic::default"

execute "yum install -y newrelic-php5"

execute "yum -q makecache" do
    action :nothing
end

execute "/usr/bin/newrelic-install install"

service "newrelic-daemon" do
  action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end