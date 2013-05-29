node[:deploy].each do |app_name, deploy|

  # use opsworks ssh key management and load the key into the ec2 instance
  prepare_git_checkouts(
    :user => deploy[:user],
    :group => deploy[:group],
    :home => deploy[:home],
    :ssh_key => deploy[:scm][:ssh_key]
  ) if deploy[:scm][:scm_type].to_s == 'git'

  # this should be in the configure reic
  execute "cd /var && git clone #{deploy[:scm][:repository]} #{app_name}" do
    ignore_failure true
  end
  
  execute "cd /var/#{app_name} && git clean -df && git reset --hard && git pull"
  
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "/var/#{app_name}"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install --prefer-source --no-interaction
    EOH
  end
  
  template "/etc/php.d/#{app_name}.ini" do
    source "php.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  web_app app_name do 
    docroot /var/#{app_name}
    template "webapp.conf.erb" 
    log_dir node['apache']['log_dir'] 
  end

  
  
end