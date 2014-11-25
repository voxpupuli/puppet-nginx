class nginx::params {
  ### Operating System Configuration
  ## This is my hacky... no hiera system. Oh well. :)
  $_module_defaults = {
    'conf_dir'    => '/etc/nginx',
    'daemon_user' => 'nginx',
    'pid'         => '/var/run/nginx.pid',
    'root_group'  => 'root',
    'log_dir'     => '/var/log/nginx',
    'run_dir'     => '/var/nginx',
  }
  case $::osfamily {
    'ArchLinux': {
      $_module_os_overrides = {
        'pid'         => false,
        'daemon_user' => 'http',
      }
    }
    'Debian': {
      $_module_os_overrides = {
        'daemon_user' => 'www-data',
      }
    }
    'FreeBSD': {
      $_module_os_overrides = {
        'conf_dir'    => '/usr/local/etc/nginx',
        'daemon_user' => 'www',
        'root_group'  => 'wheel',
      }
    }
    'Solaris': {
      $_module_os_overrides = {
        'daemon_user' => 'webservd',
      }
    }
    'OpenBSD': {
      $_module_os_overrides = {
        'daemon_user' => 'www',
        'root_group'  => 'wheel',
        'log_dir'     => '/var/www/logs',
        'run_dir'     => '/var/www',
      }
    }
    default: {
      ## For cases not covered in $::osfamily
      case $::operatingsystem {
        'SmartOS': {
          $_module_os_overrides = {
            'conf_dir'    => '/usr/local/etc/nginx',
            'daemon_user' => 'www',
          }
        }
        default: { $_module_os_overrides = {} }
      }
    }
  }

  $_module_parameters = merge($_module_defaults, $_module_os_overrides)
  ### END Operating System Configuration

  ### Referenced Variables
  $conf_dir              = $_module_parameters['conf_dir']
  $log_dir               = $_module_parameters['log_dir']
  $run_dir               = $_module_parameters['run_dir']
  $temp_dir              = '/tmp'
  $pid                   = $_module_parameters['pid']

  $client_body_temp_path = "${run_dir}/client_body_temp"
  $daemon_user           = $_module_parameters['daemon_user']
  $global_owner          = 'root'
  $global_group          = $_module_parameters['root_group']
  $global_mode           = '0644'
  $http_access_log       = "${log_dir}/access.log"
  $nginx_error_log       = "${log_dir}/error.log"
  $root_group            = $_module_parameters['root_group']
  $proxy_temp_path       = "${run_dir}/proxy_temp"
  $sites_available_owner = 'root'
  $sites_available_group = $_module_parameters['root_group']
  $sites_available_mode  = '0644'
  $super_user            = true
  ### END Referenced Variables
}
