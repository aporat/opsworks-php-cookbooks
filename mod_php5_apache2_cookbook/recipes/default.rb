case node[:platform]
    
    when "amazon"
    node.set['mysql']['server']['packages'] = %w{mysql55w-server}
    node.set['mysql']['client']['packages'] = %w{mysql55w}

    include_recipe "build-essential"
    include_recipe "apache2::default"
    include_recipe "apache2::mod_rewrite"

    # add the webtatic repository
    yum_repository "webtatic" do
        repo_name "webtatic"
        description "webtatic Stable repo"
        url "http://repo.webtatic.com/yum/el6/x86_64/"
        key "RPM-GPG-KEY-webtatic-andy"
        action :add
    end
    
    yum_key "RPM-GPG-KEY-webtatic-andy" do
        url "http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy"
        action :add
    end
    
    
    # remove any existing php/mysql
    execute "yum remove -y php* mysql*"
    
    # get the metadata
    execute "yum -q makecache"
    
    # manually install php 5.5
    execute "yum install -y php55w php55w-devel php55w-cli php55w-snmp php55w-soap php55w-xml php55w-xmlrpc php55w-process php55w-mysqlnd php55w-pecl-memcache php55w-opcache php55w-pdo php55w-imap php55w-mbstring php55w-intl"

  when "rhel", "fedora", "suse", "centos"
  # add the webtatic repository
  yum_repository "webtatic" do
    repo_name "webtatic"
    description "webtatic Stable repo"
    url "http://repo.webtatic.com/yum/el6/x86_64/"
    key "RPM-GPG-KEY-webtatic-andy"
    action :add
  end

  yum_key "RPM-GPG-KEY-webtatic-andy" do
    url "http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy"
    action :add
  end
  
  node.set['php']['packages'] = ['php55w', 'php55w-devel', 'php55w-cli', 'php55w-snmp', 'php55w-soap', 'php55w-xml', 'php55w-xmlrpc', 'php55w-process', 'php55w-mysqlnd', 'php55w-pecl-memcache', 'php55w-opcache', 'php55w-pdo', 'php55w-imap', 'php55w-mbstring', 'php55w-intl']
  node.set['mysql']['server']['packages'] = %w{mysql55w-server}
  node.set['mysql']['client']['packages'] = %w{mysql55w}

  include_recipe "build-essential"
  include_recipe "apache2::default"
  include_recipe "apache2::mod_rewrite"
  include_recipe "php"

  when "debian"
    include_recipe "apt"
	apt_repository "wheezy-php55" do
		uri "#{node['php55']['dotdeb']['uri']}"
		distribution "#{node['php55']['dotdeb']['distribution']}-php55"
		components ['all']
		key "http://www.dotdeb.org/dotdeb.gpg"
		action :add
	end
	
	  include_recipe "php"
  end