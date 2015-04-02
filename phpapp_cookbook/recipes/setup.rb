include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "mod_php5_apache2::default"

execute "yum remove -y mysql-libs.x86_64" do
  ignore_failure true
end

package "git"
package "mysql55w"
package "python-setuptools"

# disable opcache fast shutdown
execute "sed -i 's/opcache.fast_shutdown=1/opcache.fast_shutdown=0/g' /etc/php.d/opcache.ini" do
    ignore_failure true
end

execute "curl -sS https://getcomposer.org/installer | php" do
    ignore_failure true
end

execute "mv composer.phar /usr/local/bin/composer" do
    ignore_failure true
end
