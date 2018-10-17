app = search(:aws_opsworks_app).first

# deploy git repo from opsworks app
application node['phpapp']['home'] do
  git node['phpapp']['home'] do
    repository app['app_source']['url']
    deploy_key app['app_source']['ssh_key']
  end
end

composer_project node['phpapp']['home'] do
    dev false
    quiet true
    prefer_dist false
    prefer_source true
    optimize_autoloader true
    action :install
end