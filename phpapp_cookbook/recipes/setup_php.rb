include_recipe "yum::default"
include_recipe "apt::default"

case node['platform']
  when 'amazon'
    node.override['php']['packages'] = ['php72', 'php72-devel', 'php72-cli', 'php72-bcmath', 'php72-snmp', 'php72-soap', 'php72-xml', 'php72-xmlrpc', 'php72-process', 'php72-mysqlnd', 'php72-opcache', 'php72-pdo', 'php72-imap', 'php72-mbstring', 'php72-intl', 'php72-gd', 'php72-gmp']

    node.override['apache']['package'] = 'httpd24'
    node.override['apache']['devel_package'] = 'httpd24-devel'
  when 'ubuntu'

    apt_repository 'ondrej-php' do
      uri          'ppa:ondrej/php'
      distribution node['lsb']['codename']
    end

    node.override['php']['conf_dir'] = '/etc/php/7.2/cli'
    node.override['php']['packages'] = ['php7.2', 'php7.2-cli', 'php7.2-bcmath', 'php7.2-snmp', 'php7.2-soap', 'php7.2-xml', 'php7.2-xmlrpc', 'php7.2-mysqlnd', 'php7.2-curl', 'php7.2-opcache', 'php7.2-pdo', 'php7.2-imap', 'php7.2-mbstring', 'php7.2-intl', 'php7.2-gd', 'php7.2-gmp']

  else
    node.override['php']['packages'] = ['php', 'php-devel', 'php-cli', 'php-bcmath', 'php-snmp', 'php-soap', 'php-xml', 'php-xmlrpc', 'php-process', 'php-mysqlnd', 'php-opcache', 'php-pdo', 'php-imap', 'php-mbstring', 'php-intl', 'php-gd', 'php-gmp']

    # add the EPEL repo
    yum_repository 'epel' do
      description 'Extra Packages for Enterprise Linux'
      mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=x86_64'
      gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
      action :create
    end


    # add the REMI repo
    yum_repository 'remi' do
      description "Remi's RPM repository for Enterprise Linux 7"
      mirrorlist 'http://rpms.remirepo.net/enterprise/7/remi/mirror'
      enabled true
      gpgcheck true
      gpgkey 'http://rpms.remirepo.net/RPM-GPG-KEY-remi'
    end

    yum_repository 'remi-php72' do
      description "Remi's PHP 7.2 RPM repository for Enterprise Linux 7"
      mirrorlist 'http://rpms.remirepo.net/enterprise/7/php72/mirror'
      gpgkey 'http://rpms.remirepo.net/RPM-GPG-KEY-remi'
      enabled true
      action :create
    end

  end

include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "php::package"
include_recipe "php::ini"
