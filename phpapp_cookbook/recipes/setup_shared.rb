include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "yum"
include_recipe "phpapp::setup_php5"

package "git"
package "python-setuptools"
package "ntp"
package "ntpdate"

execute "service ntpd restart" do
    ignore_failure true
end

execute "chkconfig ntpd on" do
    ignore_failure true
end

# install supervisord
execute "easy_install supervisor"

# disable opcache fast shutdown
execute "sed -i 's/opcache.fast_shutdown=1/opcache.fast_shutdown=0/g' /etc/php-5.6.ini" do
    ignore_failure true
end

execute "curl -sS https://getcomposer.org/installer | php" do
    ignore_failure true
end

execute "composer global require 'laravel/lumen-installer'" do
    ignore_failure true
end

execute "mv composer.phar /usr/local/bin/composer" do
    ignore_failure true
end