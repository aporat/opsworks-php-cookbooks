name              "mod_php5_apache2"
maintainer        "Adar Porat"
maintainer_email "adar.porat@gmail.com"
license           "Apache 2.0"
description      "Installs and config php 5.5"
version          "0.2.1"

depends "build-essential"
depends "apt"
depends "yum"
depends "php"
depends "apache2"

recipe "default", "Installs php"