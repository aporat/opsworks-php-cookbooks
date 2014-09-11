include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "mod_php5_apache2::default"

execute "yum remove -y mysql-libs.x86_64" do
  ignore_failure true
end

package "git"
