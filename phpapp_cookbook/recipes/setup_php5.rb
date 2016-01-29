case node[:platform]
  when 'amazon'
    node.set['apache']['version'] = '2.4'
    node.set['apache']['package'] = 'httpd24'
    node.set['php']['packages'] = ['php56', 'php56-devel', 'php56-cli', 'php56-snmp', 'php56-soap', 'php56-xml', 'php56-xmlrpc', 'php56-process', 'php56-mysqlnd', 'php56-pecl-memcache', 'php56-opcache', 'php56-pdo', 'php56-imap', 'php56-mbstring', 'php56-intl', 'php56-mcrypt']

  when 'rhel', 'fedora', 'suse', 'centos'
    node.set['apache']['version'] = '2.4'
    node.set['apache']['package'] = 'httpd'
    node.set['php']['packages'] = ['php56w', 'php56w-devel', 'php56w-cli', 'php56w-snmp', 'php56w-soap', 'php56w-xml', 'php56w-xmlrpc', 'php56w-process', 'php56w-mysqlnd', 'php56w-pecl-memcache', 'php56w-opcache', 'php56w-pdo', 'php56w-imap', 'php56w-mbstring', 'php56w-intl', 'php56w-mcrypt']

    if node['platform_version'].to_f >= 7
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
    else
      # add the EPEL repo
      yum_repository 'epel' do
        description 'Extra Packages for Enterprise Linux'
        mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64'
        gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
        action :create
      end

      # add the webtatic repo
      yum_repository 'webtatic' do
        description 'webtatic Project'
        mirrorlist 'http://repo.webtatic.com/yum/el6/x86_64/mirrorlist'
        gpgkey 'http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy'
        action :create
      end
    end

end

include_recipe "build-essential"
include_recipe "apache2::default"
include_recipe "apache2::mod_rewrite"
include_recipe "php"