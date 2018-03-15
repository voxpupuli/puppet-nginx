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
  String[1] $client_body_temp_path                                              = $::nginx::params::client_body_temp_path,
  Boolean $confd_only                                                           = false,
  Boolean $confd_purge                                                          = false,
  String[1] $conf_dir                                                           = $::nginx::params::conf_dir,
  Optional[Nginx::Toggle] $daemon                                               = undef,
  String[1] $daemon_user                                                        = $::nginx::params::daemon_user,
  Optional[String[1]] $daemon_group                                             = undef,
  Array[String[1]] $dynamic_modules                                             = [],
  String[1] $global_owner                                                       = $::nginx::params::global_owner,
  String[1] $global_group                                                       = $::nginx::params::global_group,
  Stdlib::Filemode $global_mode                                                 = $::nginx::params::global_mode,
  String[1] $log_dir                                                            = $::nginx::params::log_dir,
  String[1] $log_group                                                          = $::nginx::params::log_group,
  Stdlib::Filemode $log_mode                                                    = '0750',
  Variant[String[1], Array[String[1]]] $http_access_log                         = "${log_dir}/${::nginx::params::http_access_log_file}",
  Optional[String[1]] $http_format_log                                          = undef,
  Variant[String[1], Array[String[1]]] $nginx_error_log                         = "${log_dir}/${::nginx::params::nginx_error_log_file}",
  Nginx::ErrorLogSeverity $nginx_error_log_severity                             = 'error',
  Variant[String[1], Boolean] $pid                                              = $::nginx::params::pid,
  String[1] $proxy_temp_path                                                    = $::nginx::params::proxy_temp_path,
  String[1] $root_group                                                         = $::nginx::params::root_group,
  Stdlib::Unixpath $run_dir                                                     = $::nginx::params::run_dir,
  String[1] $sites_available_owner                                              = $::nginx::params::sites_available_owner,
  String[1] $sites_available_group                                              = $::nginx::params::sites_available_group,
  Stdlib::Filemode $sites_available_mode                                        = $::nginx::params::sites_available_mode,
  Boolean $super_user                                                           = $::nginx::params::super_user,
  String[1] $temp_dir                                                           = $::nginx::params::temp_dir,
  Boolean $server_purge                                                         = false,

  # Primary Templates
  String[1] $conf_template                                                      = 'nginx/conf.d/nginx.conf.erb',

  ### START Nginx Configuration ###
  Nginx::Toggle $accept_mutex                                                   = 'on',
  Nginx::Duration $accept_mutex_delay                                           = '500ms',
  String[1] $client_body_buffer_size                                            = '128k',
  String[1] $client_max_body_size                                               = '10m',
  Nginx::Duration $client_body_timeout                                          = '60s',
  Nginx::Duration $send_timeout                                                 = '60s',
  Nginx::Duration $lingering_timeout                                            = '5s',
  Optional[Nginx::Toggle] $etag                                                 = undef,
  Optional[String[1]] $events_use                                               = undef,
  Nginx::Duration $fastcgi_cache_inactive                                       = '20m',
  Optional[String[1]] $fastcgi_cache_key                                        = undef,
  String[1] $fastcgi_cache_keys_zone                                            = 'd3:100m',
  String[1] $fastcgi_cache_levels                                               = '1',
  String[1] $fastcgi_cache_max_size                                             = '500m',
  Optional[String[1]] $fastcgi_cache_path                                       = undef,
  Optional[String[1]] $fastcgi_cache_use_stale                                  = undef,
  Nginx::Toggle $gzip                                                           = 'on',
  Optional[String[1]] $gzip_buffers                                             = undef,
  Integer[1,9] $gzip_comp_level                                                 = 1,
  String[1] $gzip_disable                                                       = 'msie6',
  String[1] $gzip_min_length                                                    = '20',
  Enum['1.0', '1.1'] $gzip_http_version                                         = '1.1',
  String[1] $gzip_proxied                                                       = 'off',
  Optional[Variant[Array[String[1]], String[1]]] $gzip_types                    = undef,
  Nginx::Toggle $gzip_vary                                                      = 'off',
  Optional[Nginx::Directives] $http_cfg_prepend                                 = undef,
  Optional[Nginx::Directives] $http_cfg_append                                  = undef,
  Optional[Variant[Array[String[1]], String[1]]] $http_raw_prepend              = undef,
  Optional[Variant[Array[String[1]], String[1]]] $http_raw_append               = undef,
  Nginx::Toggle $http_tcp_nodelay                                               = 'on',
  Optional[Nginx::Toggle] $http_tcp_nopush                                      =  undef,
  Nginx::Duration $keepalive_timeout                                            = '65s',
  String[1] $keepalive_requests                                                 = '100',
  Hash[String[1],String] $log_format                                            = {},
  Boolean $mail                                                                 = false,
  Boolean $stream                                                               = false,
  Nginx::Toggle $multi_accept                                                   = 'off',
  Integer $names_hash_bucket_size                                               = 64,
  Integer $names_hash_max_size                                                  = 512,
  Optional[Nginx::Directives] $nginx_cfg_prepend                                 = undef,
  String[1] $proxy_buffers                                                      = '32 4k',
  String[1] $proxy_buffer_size                                                  = '8k',
  Nginx::Duration $proxy_cache_inactive                                         = '20m',
  String[1] $proxy_cache_keys_zone                                              = 'd2:100m',
  String[1] $proxy_cache_levels                                                 = '1',
  String[1] $proxy_cache_max_size                                               = '500m',
  Optional[Variant[Hash[String[1],String], String[1]]] $proxy_cache_path        = undef,
  Optional[Integer] $proxy_cache_loader_files                                   = undef,
  Optional[String[1]] $proxy_cache_loader_sleep                                 = undef,
  Optional[String[1]] $proxy_cache_loader_threshold                             = undef,
  Optional[Nginx::Toggle] $proxy_use_temp_path                                  = undef,
  Nginx::Duration $proxy_connect_timeout                                        = '90s',
  Integer $proxy_headers_hash_bucket_size                                       = 64,
  Optional[Enum['1.0', '1.1']] $proxy_http_version                              = undef,
  Nginx::Duration $proxy_read_timeout                                           = '90s',
  Optional[String[1]] $proxy_redirect                                           = undef,
  Nginx::Duration $proxy_send_timeout                                           = '90s',
  Array[String[1]] $proxy_set_header                                            = [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
    'Proxy ""',
  ],
  Array[String[1]] $proxy_hide_header                                           = [],
  Array[String[1]] $proxy_pass_header                                           = [],
  Array[String[1]] $proxy_ignore_header                                         = [],
  Optional[Nginx::Toggle] $sendfile                                             = undef,
  String[1] $server_tokens                                                      = 'on',
  Boolean $spdy                                                                 = false,
  Boolean $http2                                                                = false,
  Nginx::Toggle $ssl_stapling                                                   = 'off',
  Integer $types_hash_bucket_size                                               = 512,
  Integer $types_hash_max_size                                                  = 1024,
  Integer $worker_connections                                                   = 1024,
  Nginx::Toggle $ssl_prefer_server_ciphers                                      = 'on',
  Variant[Integer, Enum['auto']] $worker_processes                              = 1,
  Integer $worker_rlimit_nofile                                                 = 1024,
  String[1] $ssl_protocols                                                      = 'TLSv1 TLSv1.1 TLSv1.2',
  String[1] $ssl_ciphers                                                        = 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS', # lint:ignore:140chars
  Optional[String[1]] $ssl_dhparam                                             = undef,

  ### START Package Configuration ###
  String[1] $package_ensure                                                     = present,
  String[1] $package_name                                                       = $::nginx::params::package_name,
  String[1] $package_source                                                     = 'nginx',
  Optional[String[1]] $package_flavor                                           = undef,
  Boolean $manage_repo                                                          = $::nginx::params::manage_repo,
  Optional[String[1]] $repo_release                                             = undef,
  String[1] $passenger_package_ensure                                           = 'present',
  ### END Package Configuration ###

  ### START Service Configuation ###
  Enum['running', 'absent', 'stopped', 'undef'] $service_ensure                 = running,
  Optional[String[1]] $service_flags                                            = undef,
  Optional[String[1]] $service_restart                                          = undef,
  String[1] $service_name                                                       = 'nginx',
  Boolean $service_manage                                                       = true,
  ### END Service Configuration ###

  ### START Hiera Lookups ###
  Hash $geo_mappings                                                            = {},
  Hash $string_mappings                                                         = {},
  Hash $nginx_locations                                                         = {},
  Hash $nginx_locations_defaults                                                = {},
  Hash $nginx_mailhosts                                                         = {},
  Hash $nginx_mailhosts_defaults                                                = {},
  Hash $nginx_streamhosts                                                       = {},
  Hash $nginx_upstreams                                                         = {},
  Hash $nginx_servers                                                           = {},
  Hash $nginx_servers_defaults                                                  = {},
  Boolean $purge_passenger_repo                                                 = true,
  ### END Hiera Lookups ###
) inherits nginx::params {

  contain 'nginx::package'
  contain 'nginx::config'
  contain 'nginx::service'

  create_resources('nginx::resource::upstream', $nginx_upstreams)
  create_resources('nginx::resource::server', $nginx_servers, $nginx_servers_defaults)
  create_resources('nginx::resource::location', $nginx_locations, $nginx_locations_defaults)
  create_resources('nginx::resource::mailhost', $nginx_mailhosts, $nginx_mailhosts_defaults)
  create_resources('nginx::resource::streamhost', $nginx_streamhosts)
  create_resources('nginx::resource::map', $string_mappings)
  create_resources('nginx::resource::geo', $geo_mappings)

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  Class['nginx::package'] -> Class['nginx::config'] ~> Class['nginx::service']
  Class['nginx::package'] ~> Class['nginx::service']
}
