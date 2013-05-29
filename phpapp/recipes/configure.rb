node[:deploy].each do |app_name, deploy|

  # use opsworks ssh key management and load the key into the ec2 instance
  prepare_git_checkouts(
    :user => "root",
    :group => "root",
    :home => "/root/",
    :ssh_key => deploy[:scm][:ssh_key]
  ) if deploy[:scm][:scm_type].to_s == 'git'

  # this should be in the configure reic
  execute "cd /var && git clone #{deploy[:scm][:repository]} #{app_name}" do
    ignore_failure true
  end

  # set any php.ini settings needed
  template "/etc/php.d/#{app_name}.ini" do
    source "php.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  # set apache2 hosts
  web_app app_name do 
    docroot /var/#{app_name}
    template "webapp.conf.erb" 
    log_dir node['apache']['log_dir'] 
  end

  
  
end