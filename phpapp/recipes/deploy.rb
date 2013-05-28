node[:deploy].each do |app_name, deploy|

  phpapp_deploy do
    deploy_data deploy
    app application
  end

  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install
    EOH
  end
  
end