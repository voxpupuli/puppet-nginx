# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged NGINX
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
#  stdlib
#    - puppetlabs-stdlib module >= 0.1.6
#    - plugin sync enabled to obtain the anchor type
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx (
  $conf_dir                       = $nginx::params::conf_dir,
  $daemon_user                    = $nginx::params::daemon_user,
  $pid                            = $nginx::params::pid,
  $client_body_buffer_size        = '128k',
  $client_body_temp_path          = '/var/nginx/client_body_temp',
  $client_max_body_size           = '10m',
  $confd_purge                    = false,
  $configtest_enable              = false,
  $conf_template                  = 'nginx/conf.d/nginx.conf.erb',
  $events_use                     = false,
  $fastcgi_cache_inactive         = '20m',
  $fastcgi_cache_key              = false,
  $fastcgi_cache_keys_zone        = 'd3:100m',
  $fastcgi_cache_levels           = 1,
  $fastcgi_cache_max_size         = '500m',
  $fastcgi_cache_path             = false,
  $fastcgi_cache_use_stale        = false,
  $gzip                           = 'on',
  $http_access_log                = '/var/log/nginx/access.log',
  $http_cfg_append                = false,
  $http_tcp_nodelay               = 'on',
  $http_tcp_nopush                = 'off',
  $keepalive_timeout              = 65,
  $logdir                         = '/var/log/nginx',
  $mail                           = false,
  $manage_repo                    = true,
  $multi_accept                   = 'off',
  $names_hash_bucket_size         = 64,
  $names_hash_max_size            = 512,
  $nginx_error_log                = '/var/log/nginx/access.log',
  $nginx_locations                = {},
  $nginx_mailhosts                = {},
  $nginx_upstreams                = {},
  $nginx_vhosts                   = {},
  $package_ensure                 = 'present',
  $package_name                   = 'nginx',
  $package_source                 = 'nginx',
  $proxy_buffers                  = '32 4k',
  $proxy_buffer_size              = '8k',
  $proxy_cache_inactive           = '20m',
  $proxy_cache_keys_zone          = 'd2:100m',
  $proxy_cache_levels             = 1,
  $proxy_cache_max_size           = '500m',
  $proxy_cache_path               = false,
  $proxy_conf_template            = 'nginx/conf.d/proxy.conf.erb',
  $proxy_connect_timeout          = 90,
  $proxy_headers_hash_bucket_size = '64',
  $proxy_http_version             = '1.0',
  $proxy_read_timeout             = 90,
  $proxy_redirect                 = 'off',
  $proxy_send_timeout             = 90,
  $proxy_set_header               = ['Host $host', 'X-Real-IP $remote_addr', 'X-Forwarded-For $proxy_add_x_forwarded_for'],
  $proxy_temp_path                = '/var/nginx/proxy_temp',
  $run_dir                        = '/var/nginx',
  $sendfile                       = 'on',
  $server_tokens                  = 'on',
  $service_ensure                 = 'running',
  $service_restart                = '/etc/init.d/nginx configtest && /etc/init.d/nginx restart',
  $spdy                           = 'off',
  $super_user                     = true,
  $temp_dir                       = '/tmp',
  $types_hash_bucket_size         = 512,
  $types_hash_max_size            = 512,
  $vhost_purge                    = false,
  $worker_connections             = 1024,
  $worker_processes               = 1,
  $worker_rlimit_nofile           = 1024,
  $global_owner                   = 'root',
  $global_group                   = $nginx::params::global_group,
  $global_mode                    = '0644',
  $sites_available_owner          = 'root',
  $sites_available_group          = $nginx::params::sites_available_group,
  $sites_available_mode           = '0644',
  $geo_mappings                   = {},
  $string_mappings                = {},
) inherits nginx::params {

  include stdlib

  if (!is_string($worker_processes)) and (!is_integer($worker_processes)) {
    fail('$worker_processes must be an integer or have value "auto".')
  }
  if (!is_integer($worker_connections)) {
    fail('$worker_connections must be an integer.')
  }
  if (!is_integer($worker_rlimit_nofile)) {
    fail('$worker_rlimit_nofile must be an integer.')
  }
  if (!is_string($events_use)) and ($events_use != false) {
    fail('$events_use must be a string or false.')
  }
  validate_string($multi_accept)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_string($package_source)
  validate_array($proxy_set_header)
  validate_string($proxy_http_version)
  validate_bool($confd_purge)
  validate_bool($vhost_purge)
  if ($proxy_cache_path != false) {
    validate_string($proxy_cache_path)
  }
  if (!is_integer($proxy_cache_levels)) {
    fail('$proxy_cache_levels must be an integer.')
  }
  validate_string($proxy_cache_keys_zone)
  validate_string($proxy_cache_max_size)
  validate_string($proxy_cache_inactive)

  if ($fastcgi_cache_path != false) {
        validate_string($fastcgi_cache_path)
  }
  if (!is_integer($fastcgi_cache_levels)) {
    fail('$fastcgi_cache_levels must be an integer.')
  }
  validate_string($fastcgi_cache_keys_zone)
  validate_string($fastcgi_cache_max_size)
  validate_string($fastcgi_cache_inactive)
  if ($fastcgi_cache_key != false) {
    validate_string($fastcgi_cache_key)
  }
  if ($fastcgi_cache_use_stale != false) {
    validate_string($fastcgi_cache_use_stale)
  }

  validate_bool($configtest_enable)
  validate_string($service_restart)
  validate_bool($mail)
  validate_string($server_tokens)
  validate_string($client_max_body_size)
  if (!is_integer($names_hash_bucket_size)) {
    fail('$names_hash_bucket_size must be an integer.')
  }
  if (!is_integer($names_hash_max_size)) {
    fail('$names_hash_max_size must be an integer.')
  }
  validate_string($proxy_buffers)
  validate_string($proxy_buffer_size)
  if ($http_cfg_append != false) {
    if !(is_hash($http_cfg_append) or is_array($http_cfg_append)) {
      fail('$http_cfg_append must be either a hash or array')
    }
  }

  validate_string($nginx_error_log)
  validate_string($http_access_log)
  validate_hash($nginx_upstreams)
  validate_hash($nginx_vhosts)
  validate_hash($nginx_locations)
  validate_hash($nginx_mailhosts)
  validate_bool($manage_repo)
  validate_string($proxy_headers_hash_bucket_size)
  validate_bool($super_user)

  validate_hash($string_mappings)
  validate_hash($geo_mappings)

  include 'nginx::package'
  include 'nginx::config'
  include 'nginx::service'

  Class['nginx::package'] ~>
  Class['nginx::service']

  Class['nginx::package'] ->
  Class['nginx::config'] ~>
  Class['nginx::service']

  create_resources('nginx::resource::upstream', $nginx_upstreams)
  create_resources('nginx::resource::vhost', $nginx_vhosts)
  create_resources('nginx::resource::location', $nginx_locations)
  create_resources('nginx::resource::mailhost', $nginx_mailhosts)
  create_resources('nginx::resource::map', $string_mappings)
  create_resources('nginx::resource::geo', $geo_mappings)

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'nginx::begin':
    before => Class['nginx::package'],
    notify => Class['nginx::service'],
  }
  anchor { 'nginx::end':
    require => Class['nginx::service'],
  }
}
