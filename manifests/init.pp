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
  ### START Nginx Configuration ###
  $client_body_temp_path          = $::nginx::params::client_body_temp_path,
  $confd_only                     = false,
  $confd_purge                    = false,
  $conf_dir                       = $::nginx::params::conf_dir,
  $daemon                         = undef,
  $daemon_user                    = $::nginx::params::daemon_user,
  $global_owner                   = $::nginx::params::global_owner,
  $global_group                   = $::nginx::params::global_group,
  $global_mode                    = $::nginx::params::global_mode,
  $log_dir                        = $::nginx::params::log_dir,
  $log_group                      = $::nginx::params::log_group,
  $log_mode                       = '0750',
  $http_access_log                = "${log_dir}/${::nginx::params::http_access_log_file}",
  $http_format_log                = undef,
  $nginx_error_log                = "${log_dir}/${::nginx::params::nginx_error_log_file}",
  $nginx_error_log_severity       = 'error',
  $pid                            = $::nginx::params::pid,
  $proxy_temp_path                = $::nginx::params::proxy_temp_path,
  $root_group                     = $::nginx::params::root_group,
  $run_dir                        = $::nginx::params::run_dir,
  $sites_available_owner          = $::nginx::params::sites_available_owner,
  $sites_available_group          = $::nginx::params::sites_available_group,
  $sites_available_mode           = $::nginx::params::sites_available_mode,
  $super_user                     = $::nginx::params::super_user,
  $temp_dir                       = $::nginx::params::temp_dir,
  $server_purge                   = false,

  # Primary Templates
  $conf_template                  = 'nginx/conf.d/nginx.conf.erb',
  $proxy_conf_template            = undef,

  ### START Nginx Configuration ###
  $accept_mutex                   = 'on',
  $accept_mutex_delay             = '500ms',
  $client_body_buffer_size        = '128k',
  $client_max_body_size           = '10m',
  $client_body_timeout            = '60',
  $send_timeout                   = '60',
  $lingering_timeout              = '5',
  $events_use                     = false,
  $fastcgi_cache_inactive         = '20m',
  $fastcgi_cache_key              = false,
  $fastcgi_cache_keys_zone        = 'd3:100m',
  $fastcgi_cache_levels           = '1',
  $fastcgi_cache_max_size         = '500m',
  $fastcgi_cache_path             = false,
  $fastcgi_cache_use_stale        = false,
  $gzip                           = 'on',
  $gzip_buffers                   = undef,
  $gzip_comp_level                = 1,
  $gzip_disable                   = 'msie6',
  $gzip_min_length                = 20,
  $gzip_http_version              = 1.1,
  $gzip_proxied                   = 'off',
  $gzip_types                     = undef,
  $gzip_vary                      = 'off',
  $http_cfg_prepend               = false,
  $http_cfg_append                = false,
  $http_tcp_nodelay               = 'on',
  $http_tcp_nopush                = 'off',
  $keepalive_timeout              = '65',
  $keepalive_requests             = '100',
  $log_format                     = {},
  $mail                           = false,
  $stream                         = false,
  $multi_accept                   = 'off',
  $names_hash_bucket_size         = '64',
  $names_hash_max_size            = '512',
  $nginx_cfg_prepend              = false,
  $proxy_buffers                  = '32 4k',
  $proxy_buffer_size              = '8k',
  $proxy_cache_inactive           = '20m',
  $proxy_cache_keys_zone          = 'd2:100m',
  $proxy_cache_levels             = '1',
  $proxy_cache_max_size           = '500m',
  $proxy_cache_path               = false,
  $proxy_cache_loader_files       = undef,
  $proxy_cache_loader_sleep       = undef,
  $proxy_cache_loader_threshold   = undef,
  $proxy_use_temp_path            = false,
  $proxy_connect_timeout          = '90',
  $proxy_headers_hash_bucket_size = '64',
  $proxy_http_version             = undef,
  $proxy_read_timeout             = '90',
  $proxy_redirect                 = undef,
  $proxy_send_timeout             = '90',
  $proxy_set_header               = [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
    'Proxy ""',
  ],
  $proxy_hide_header              = [],
  $proxy_pass_header              = [],
  $sendfile                       = 'on',
  $server_tokens                  = 'on',
  $spdy                           = 'off',
  $http2                          = 'off',
  $ssl_stapling                   = 'off',
  $types_hash_bucket_size         = '512',
  $types_hash_max_size            = '1024',
  $worker_connections             = '1024',
  $worker_processes               = '1',
  $worker_rlimit_nofile           = '1024',
  $ssl_protocols                  = 'TLSv1 TLSv1.1 TLSv1.2',
  $ssl_ciphers                    = 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS',

  ### START Package Configuration ###
  $package_ensure                 = present,
  $package_name                   = $::nginx::params::package_name,
  $package_source                 = 'nginx',
  $package_flavor                 = undef,
  $manage_repo                    = $::nginx::params::manage_repo,
  $passenger_package_ensure       = 'present',
  ### END Package Configuration ###

  ### START Service Configuation ###
  $service_ensure                 = running,
  $service_flags                  = undef,
  $service_restart                = undef,
  $service_name                   = undef,
  $service_manage                 = true,
  ### END Service Configuration ###

  ### START Hiera Lookups ###
  $geo_mappings                   = {},
  $string_mappings                = {},
  $nginx_locations                = {},
  $nginx_mailhosts                = {},
  $nginx_streamhosts              = {},
  $nginx_upstreams                = {},
  $nginx_servers                  = {},
  $nginx_servers_defaults         = {},
  ### END Hiera Lookups ###
) inherits ::nginx::params {

  ### Validations ###
  if ($worker_processes != 'auto') and (!is_integer($worker_processes)) {
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
  validate_array($proxy_set_header)
  validate_array($proxy_hide_header)
  validate_array($proxy_pass_header)
  if ($proxy_http_version != undef) {
    validate_string($proxy_http_version)
  }
  if ($proxy_conf_template != undef) {
    warning('The $proxy_conf_template parameter is deprecated and has no effect.')
  }
  validate_bool($confd_only)
  validate_bool($confd_purge)
  validate_bool($server_purge)
  if ( $proxy_cache_path != false) {
    if ( is_string($proxy_cache_path) or is_hash($proxy_cache_path)) {}
    else {
      fail('proxy_cache_path must be a string or a hash')
    }
  }
  validate_re($proxy_cache_levels, '^[12](:[12])*$')
  validate_string($proxy_cache_keys_zone)
  validate_string($proxy_cache_max_size)
  validate_string($proxy_cache_inactive)

  if ($proxy_cache_loader_files != undef) and !is_integer($proxy_cache_loader_files) {
    fail('proxy_cache_loader_files must be an integer')
  }
  validate_string($proxy_cache_loader_sleep)
  validate_string($proxy_cache_loader_threshold)

  if ($proxy_use_temp_path != false) {
        validate_re($proxy_use_temp_path, '^(on|off)$')
  }

  if ($fastcgi_cache_path != false) {
        validate_string($fastcgi_cache_path)
  }
  validate_re($fastcgi_cache_levels, '^[12](:[12])*$')
  validate_string($fastcgi_cache_keys_zone)
  validate_string($fastcgi_cache_max_size)
  validate_string($fastcgi_cache_inactive)
  if ($fastcgi_cache_key != false) {
    validate_string($fastcgi_cache_key)
  }
  if ($fastcgi_cache_use_stale != false) {
    validate_string($fastcgi_cache_use_stale)
  }

  validate_bool($mail)
  validate_bool($stream)
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
  if ($http_cfg_prepend != false) {
    if !(is_hash($http_cfg_prepend) or is_array($http_cfg_prepend)) {
      fail('$http_cfg_prepend must be either a hash or array')
    }
  }

  if ($http_cfg_append != false) {
    if !(is_hash($http_cfg_append) or is_array($http_cfg_append)) {
      fail('$http_cfg_append must be either a hash or array')
    }
  }

  if ($nginx_cfg_prepend != false) {
    if !(is_hash($nginx_cfg_prepend) or is_array($nginx_cfg_prepend)) {
      fail('$nginx_cfg_prepend must be either a hash or array')
    }
  }

  if !(is_string($http_access_log) or is_array($http_access_log)) {
    fail('$http_access_log must be either a string or array')
  }

  if !(is_string($nginx_error_log) or is_array($nginx_error_log)) {
    fail('$nginx_error_log must be either a string or array')
  }

  validate_re($nginx_error_log_severity,['debug','info','notice','warn','error','crit','alert','emerg'],'$nginx_error_log_severity must be debug, info, notice, warn, error, crit, alert or emerg')
  validate_string($proxy_headers_hash_bucket_size)
  validate_bool($super_user)
  ### END VALIDATIONS ###

  class { '::nginx::package':
    package_name             => $package_name,
    package_source           => $package_source,
    package_ensure           => $package_ensure,
    package_flavor           => $package_flavor,
    passenger_package_ensure => $passenger_package_ensure,
    notify                   => Class['::nginx::service'],
    manage_repo              => $manage_repo,
  }

  include '::nginx::config'
  include '::nginx::service'

  Class['::nginx::package'] -> Class['::nginx::config'] ~> Class['::nginx::service']

  create_resources('nginx::resource::upstream', $nginx_upstreams)
  create_resources('nginx::resource::server', $nginx_servers, $nginx_servers_defaults)
  create_resources('nginx::resource::location', $nginx_locations)
  create_resources('nginx::resource::mailhost', $nginx_mailhosts)
  create_resources('nginx::resource::streamhost', $nginx_streamhosts)
  create_resources('nginx::resource::map', $string_mappings)
  create_resources('nginx::resource::geo', $geo_mappings)

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'nginx::begin':
    before => Class['::nginx::package'],
    notify => Class['::nginx::service'],
  }
  anchor { 'nginx::end':
    require => Class['::nginx::service'],
  }
}
