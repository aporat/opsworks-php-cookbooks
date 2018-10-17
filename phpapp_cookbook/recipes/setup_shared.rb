include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "yum"
include_recipe "phpapp::setup_php"
include_recipe "composer::default"
include_recipe "ntp::default"

package "git"

# disable opcache fast shutdown
execute "sed -i 's/opcache.fast_shutdown=1/opcache.fast_shutdown=0/g' /etc/php.d/opcache.ini" do
    ignore_failure true
end

execute "sed -i 's/opcache.fast_shutdown=1/opcache.fast_shutdown=0/g' /etc/php.ini" do
    ignore_failure true
end