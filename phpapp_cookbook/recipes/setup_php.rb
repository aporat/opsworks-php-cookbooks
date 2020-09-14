include_recipe "yum::default"

  # add the EPEL repo
    yum_repository 'epel' do
      description 'Extra Packages for Enterprise Linux'
      mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=x86_64'
      gpgkey 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
      action :create
    end

case node['platform']
  when 'amazon'

    execute "sudo amazon-linux-extras install -y php7.4" do
        ignore_failure true
    end

    node.override['php']['packages'] = ['php', 'php-devel', 'php-cli', 'php-bcmath', 'php-snmp', 'php-soap', 'php-xml', 'php-xmlrpc', 'php-process', 'php-mysqlnd', 'php-opcache', 'php-pdo', 'php-mbstring', 'php-intl', 'php-gd', 'php-gmp', 'php-zip', 'php-pecl-redis']
  else

    # add the REMI repo
    yum_repository 'remi' do
      description "Remi's RPM repository for Enterprise Linux 7"
      mirrorlist 'https://rpms.remirepo.net/enterprise/7/remi/mirror'
      enabled true
      gpgcheck true
      gpgkey 'https://rpms.remirepo.net/RPM-GPG-KEY-remi'
    end

    yum_repository 'remi-php74' do
      description "Remi's PHP 7.4 RPM repository for Enterprise Linux 7"
      mirrorlist 'http://rpms.remirepo.net/enterprise/7/php74/mirror'
      gpgkey 'https://rpms.remirepo.net/RPM-GPG-KEY-remi'
      enabled true
      action :create
    end
    node.override['php']['packages'] = ['php', 'php-devel', 'php-cli', 'php-bcmath', 'php-snmp', 'php-soap', 'php-xml', 'php-xmlrpc', 'php-process', 'php-mysqlnd', 'php-opcache', 'php-pdo', 'php-mbstring', 'php-intl', 'php-gd', 'php-gmp', 'php-zip', 'php-pecl-redis']
  end

include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "php::package"
include_recipe "php::ini"
