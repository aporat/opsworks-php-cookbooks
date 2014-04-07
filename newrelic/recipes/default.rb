#
# Install newrelic yum repository
#

execute "yum -q makecache" do
  action :nothing
end

execute "add newrelic repository" do
  command "rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm"
  creates "/etc/yum.repos.d/newrelic.repo"
end

execute "yum -q makecache" do
  action :nothing
end

execute "yum install -y newrelic-sysmond"

execute "yum -q makecache" do
  action :nothing
end


execute "yum -q makecache" do
  action :nothing
end

execute "newrelic config" do
  command "/usr/sbin/nrsysmond-config --set license_key=#{node['newrelic']['key']}"
end

ENV['NR_INSTALL_SILENT'] = "1"
ENV['NR_INSTALL_KEY'] = "#{node['newrelic']['key']}"

service "newrelic-sysmond" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start] #starts the service if it's not running and enables it to start at system boot time
end
