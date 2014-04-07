maintainer "Adar Porat"

description "Deploys PHP git applications"
version "1.0"

recipe "deploy::php", "Deploys a PHP application"

depends "dependencies"
depends "scm_helper"
depends "build-essential"
depends "apt"
depends "yum"
depends "mysql"
depends "apache2"
depends "openssl"
depends "mod_php5_apache2"
depends "php"
depends "python"
depends "phpmyadmin"