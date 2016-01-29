app = search(:aws_opsworks_app).first
app_path = "/var/app"

# deploy git repo from opsworks app
application app_path do
  git app_path do
    repository app['app_source']['url']
    deploy_key app['app_source']['ssh_key']
  end
end

# install composer
script "install_composer" do
  interpreter "bash"
  user "root"
  cwd "/var/app"
  code <<-EOH
  composer install --prefer-source --optimize-autoloader  --no-interaction
  EOH
end
