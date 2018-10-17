default['yum']['main']['exclude'] = 'kernel'

default['phpapp']['env'] = 'production'
default['phpapp']['home'] = '/var/app'
default['phpapp']['rds'] = 'localhost'

default['composer']['php_recipe'] = 'php::package'

default['apache']['version'] = '2.4'

default['php']['directives'] = {
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

default['ntp']['sync_clock'] = true
