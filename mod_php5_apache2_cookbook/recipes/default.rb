case node[:platform]

  when "rhel", "fedora", "suse", "centos", "amazon"
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

      node.set['apache']['version'] = '2.2'
      node.set['apache']['package'] = 'httpd'

      node.set['php']['packages'] = ['php56w', 'php56w-devel', 'php56w-cli', 'php56w-snmp', 'php56w-soap', 'php56w-xml', 'php56w-xmlrpc', 'php56w-process', 'php56w-mysqlnd', 'php56w-pecl-memcache', 'php56w-opcache', 'php56w-pdo', 'php56w-imap', 'php56w-mbstring', 'php56w-intl', 'php56w-mcrypt']

      # manual install
      # execute "yum install -y php56w php56w-devel php56w-cli php56w-snmp php56w-soap php56w-xml php56w-xmlrpc php56w-process php56w-mysqlnd php56w-pecl-memcache php56w-opcache php56w-pdo php56w-imap php56w-mbstring php56w-intl php56w-mcrypt"

      include_recipe "build-essential"
      include_recipe "apache2::default"
      include_recipe "apache2::mod_rewrite"
      include_recipe "php"

end