include_attribute "apache2"

default[:composer][:user]  = node[:apache][:user]
default[:composer][:group] = node[:apache][:group]