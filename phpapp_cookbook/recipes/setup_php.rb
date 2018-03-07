node.override['apache']['version'] = '2.4'

node.override['php']['directives'] = {
  'date.timezone' => 'UTC',
  'upload_tmp_dir' => '/tmp',
  'display_errors' => 'Off',
  'memory_limit' => '128M',
  'post_max_size' => '16M',
  'output_buffering' => 'On',
  'short_open_tag' => 'On',
  'session.save_path' => '/tmp',
  'error_log' => '/var/log/php_errors.log',
  'max_input_vars' => '10000',
  'opcache.fast_shutdown' => '0',
  'upload_max_filesize' => '12M'
}

case node[:platform]
  when 'rhel', 'fedora', 'suse', 'centos'
    node.override['php']['packages'] = ['php71w', 'php71w-devel', 'php71w-cli', 'php71w-bcmath', 'php71w-snmp', 'php71w-soap', 'php71w-xml', 'php71w-xmlrpc', 'php71w-process', 'php71w-mysqlnd', 'php71w-opcache', 'php71w-pdo', 'php71w-imap', 'php71w-mbstring', 'php71w-intl', 'php71w-mcrypt', 'php71w-gd']

    # add the EPEL repo
    yum_repository 'epel' do
      description 'Extra Packages for Enterprise Linux'
      mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=x86_64'
      gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
      action :create
    end

    # add the webtatic repo
    yum_repository 'webtatic' do
      description 'webtatic Project'
      mirrorlist 'http://repo.webtatic.com/yum/el7/x86_64/mirrorlist'
      gpgkey 'http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-el7'
      action :create
    end

    include_recipe "php::package"
    include_recipe "php::ini"
    include_recipe "apache2::default"
    include_recipe "apache2::mod_rewrite"

 when 'amazon'
    node.override['php']['packages'] = ['php71', 'php71-devel', 'php71-cli', 'php71-bcmath', 'php71-snmp', 'php71-soap', 'php71-xml', 'php71-xmlrpc', 'php71-process', 'php71-mysqlnd', 'php71-opcache', 'php71-pdo', 'php71-imap', 'php71-mbstring', 'php71-intl', 'php71-mcrypt', 'php71-gd']

    include_recipe "php::package"
    include_recipe "php::ini"
    include_recipe "apache2::default"
    include_recipe "apache2::mod_rewrite"

    end

include_recipe "build-essential"