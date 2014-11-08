class nginx::params {
  ### Operating System Configuration
  case $::osfamily {
    'Archlinux': {
      $_pid         = false
      $_daemon_user = 'http'
    }
    'Debian': {
      $_pid         = 'www-data'
    }
    'FreeBSD': {
      $_conf_dir    = '/usr/local/etc/nginx'
      $_daemon_user = 'www'
      $_root_group  = 'wheel'
    }
    'Solaris': {
      $_daemon_user = 'webservd'
    }
    default: {
      ## For cases not covered in $::osfamily
      case $::operatingsystem {
        'SmartOS': {
          $_conf_dir    = '/opt/local/etc/nginx'
          $_daemon_user = 'www'
        }
        ## True module defaults
        default: {
          $_conf_dir    = '/etc/nginx'
          $_daemon_user = 'nginx'
          $_pid         = '/var/run/nginx.pid'
          $_root_group  = 'root'
        }
      }
    }
  }
  ### END Operating System Configuration

  ### Referenced Variables
  $conf_dir              = '/etc/nginx'
  $log_dir               = '/var/log/nginx'
  $run_dir               = '/var/nginx'
  $temp_dir              = '/tmp'
  $pid                   = $_pid

  $client_body_temp_path = "${run_dir}/client_body_temp"
  $daemon_user           = $_daemon_user
  $global_owner          = 'root'
  $global_group          = 'root'
  $global_mode           = '0644'
  $http_access_log       = "${log_dir}/access.log"
  $nginx_error_log       = "${log_dir}/error.log"
  $root_group            = $_root_group
  $proxy_temp_path       = "${run_dir}/proxy_temp_path"
  $sites_available_owner = 'root'
  $sites_available_group = 'root'
  $sites_available_mode  = '0644'
  $super_user            = true
  ### END Referenced Variables
}
