
case node[:platform]
    
    when "amazon"
    #node.set['php']['packages'] = ['php54', 'php54-devel', 'php54-cli', 'php54-snmp', 'php54-soap', 'php54-xml', 'php54-xmlrpc', 'php54-process', 'php54-mysql', 'php54-pdo', 'php54-gd', 'php54-imap', 'php54-mbstring']
    node.set['mysql']['server']['packages'] = %w{mysql55-server}
    node.set['mysql']['client']['packages'] = %w{mysql55}
    
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
    
    # manually install php 5.4....
    execute "yum install -y --skip-broken php54w php54w-devel php54w-cli php54w-snmp php54w-soap php54w-xml php54w-xmlrpc php54w-process php54w-mysql55 php54w-pecl-memcache php54w-pecl-apc php54w-pear php54w-pdo php54w-gd php54w-imap php54w-mbstring"

end
