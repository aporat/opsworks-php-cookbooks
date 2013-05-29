node[:deploy].each do |app_name, deploy|
  
  # use simple git pull to deploy code changes
  execute "cd /var/#{app_name} && git clean -df && git reset --hard && git pull"
  
  # install composer
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "/var/#{app_name}"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install --prefer-source --no-interaction
    EOH
  end
  
end