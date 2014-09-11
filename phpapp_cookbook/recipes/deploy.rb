node[:deploy].each do |application, deploy|
  
  # use opsworks ssh key management and load the key into the ec2 instance
  prepare_git_checkouts(
    :user => "root",
    :group => "root",
    :home => "/root/",
    :ssh_key => deploy[:scm][:ssh_key]
  ) if deploy[:scm][:scm_type].to_s == 'git'

  # clone the repo
  execute "cd /var && git clone #{deploy[:scm][:repository]} #{node['phpapp']['app_name']}" do
    ignore_failure true
  end

  # set any php.ini settings needed
  template "/etc/php.d/#{node['phpapp']['app_name']}.ini" do
    source "php.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  # use opsworks ssh key management and load the key into the ec2 instance. 
  # it's helpful to have the deploy key loaded into the root user

  # copy ssh key to root user
  execute "touch /root/.ssh/id_deploy" do
    ignore_failure true
  end
  
  ssh_key = deploy[:scm][:ssh_key]
  
  execute "copy ssh_key" do
    command "echo '#{ssh_key}' > /root/.ssh/id_deploy"
  end
  
  execute "chmod 0600 /root/.ssh/id_deploy" do
    ignore_failure true
  end

  # make sure the ssh key is loaded
  execute "eval `ssh-agent -s`"
  execute "ssh-agent bash -c 'ssh-add /root/.ssh/id_deploy'"

  # set apache2 hosts
  web_app "#{node['phpapp']['app_name']}" do
    server_name "#{node['phpapp']['hostname']}"
    docroot "/var/#{node['phpapp']['app_name']}/public"
    template "webapp.conf.erb"
    log_dir node['apache']['log_dir'] 
  end

  # use simple git pull to deploy code changes
  execute "cd /var/#{node['phpapp']['app_name']} && git clean -df && git reset --hard && git pull"
  
  # install composer
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "/var/#{node['phpapp']['app_name']}"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install --prefer-source --optimize-autoloader  --no-interaction
    EOH
  end
  
  # start the worker on server reboot
  execute "echo \"supervisord -c /var/#{node['phpapp']['app_name']}/bin/supervisord.conf\" >> /etc/rc.d/rc.local" do
      not_if "grep -q supervisord /etc/rc.d/rc.local"
  end
  
  # Run supervisord with the config file.
  #
  # This will actually execute only on first deployment.
  # Then, since supervisord is already running, it will give out an error and do nothing.
  execute "supervisord -c /var/#{node['phpapp']['app_name']}/bin/supervisord.conf" do
      ignore_failure true
  end
  
  # https://github.com/chrisboulton/php-resque#signals
  # wait for the worker to finish and then kill it so supervisord will restart it
  execute "ps aux | grep resque-1.2 | grep -v grep | awk '{print $2}' | xargs kill -QUIT" do
      ignore_failure true
  end
  
end