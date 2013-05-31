default[:phpapp][:env] = 'development'
default[:phpapp][:domain] = 'example.com'
default[:phpapp][:timezone] = 'UTC'

node.default['phpapp']['deploy']['user'] = "root"
node.default['phpapp']['deploy']['group'] = "root"
node.default['phpapp']['deploy']['home'] = "/root/"