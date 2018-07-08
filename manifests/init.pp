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
  $client_body_temp_path                                     = $nginx::params::client_body_temp_path,
  Boolean $confd_only                                        = false,
  Boolean $confd_purge                                       = false,
  $conf_dir                                                  = $nginx::params::conf_dir,
  Optional[Enum['on', 'off']] $daemon                        = undef,
  $daemon_user                                               = $nginx::params::daemon_user,
  $daemon_group                                              = undef,
  Array[String] $dynamic_modules                             = [],
  $global_owner                                              = $nginx::params::global_owner,
  $global_group                                              = $nginx::params::global_group,
  $global_mode                                               = $nginx::params::global_mode,
  $log_dir                                                   = $nginx::params::log_dir,
  $log_group                                                 = $nginx::params::log_group,
  $log_mode                                                  = '0750',
  Variant[String, Array[String]] $http_access_log            = "${log_dir}/${::nginx::params::http_access_log_file}",
  $http_format_log                                           = undef,
  Variant[String, Array[String]] $nginx_error_log            = "${log_dir}/${::nginx::params::nginx_error_log_file}",
  Nginx::ErrorLogSeverity $nginx_error_log_severity          = 'error',
  $pid                                                       = $nginx::params::pid,
  $proxy_temp_path                                           = $nginx::params::proxy_temp_path,
  $root_group                                                = $nginx::params::root_group,
  $run_dir                                                   = $nginx::params::run_dir,
  $sites_available_owner                                     = $nginx::params::sites_available_owner,
  $sites_available_group                                     = $nginx::params::sites_available_group,
  $sites_available_mode                                      = $nginx::params::sites_available_mode,
  Boolean $super_user                                        = $nginx::params::super_user,
  $temp_dir                                                  = $nginx::params::temp_dir,
  Boolean $server_purge                                      = false,

  # Primary Templates
  $conf_template                                             = 'nginx/conf.d/nginx.conf.erb',

  ### START Nginx Configuration ###
  Optional[Enum['on', 'off']] $absolute_redirect             = undef,
  $accept_mutex                                              = 'on',
  $accept_mutex_delay                                        = '500ms',
  $client_body_buffer_size                                   = '128k',
  String $client_max_body_size                               = '10m',
  $client_body_timeout                                       = '60s',
  $send_timeout                                              = '60s',
  $lingering_timeout                                         = '5s',
  Optional[Enum['on', 'off']] $etag                          = undef,
  Optional[String] $events_use                               = undef,
  String $fastcgi_cache_inactive                             = '20m',
  Optional[String] $fastcgi_cache_key                        = undef,
  String $fastcgi_cache_keys_zone                            = 'd3:100m',
  String $fastcgi_cache_levels                               = '1',
  String $fastcgi_cache_max_size                             = '500m',
  Optional[String] $fastcgi_cache_path                       = undef,
  Optional[String] $fastcgi_cache_use_stale                  = undef,
  $gzip                                                      = 'on',
  $gzip_buffers                                              = undef,
  $gzip_comp_level                                           = 1,
  $gzip_disable                                              = 'msie6',
  $gzip_min_length                                           = 20,
  $gzip_http_version                                         = 1.1,
  $gzip_proxied                                              = 'off',
  $gzip_types                                                = undef,
  $gzip_vary                                                 = 'off',
  Optional[Variant[Hash, Array]] $http_cfg_prepend           = undef,
  Optional[Variant[Hash, Array]] $http_cfg_append            = undef,
  Optional[Variant[Array[String], String]] $http_raw_prepend = undef,
  Optional[Variant[Array[String], String]] $http_raw_append  = undef,
  $http_tcp_nodelay                                          = 'on',
  $http_tcp_nopush                                           = 'off',
  $keepalive_timeout                                         = '65s',
  $keepalive_requests                                        = '100',
  $log_format                                                = {},
  Boolean $mail                                              = false,
  Boolean $stream                                            = false,
  String $multi_accept                                       = 'off',
  Integer $names_hash_bucket_size                            = 64,
  Integer $names_hash_max_size                               = 512,
  $nginx_cfg_prepend                                         = false,
  String $proxy_buffers                                      = '32 4k',
  String $proxy_buffer_size                                  = '8k',
  String $proxy_cache_inactive                               = '20m',
  String $proxy_cache_keys_zone                              = 'd2:100m',
  String $proxy_cache_levels                                 = '1',
  String $proxy_cache_max_size                               = '500m',
  Optional[Variant[Hash, String]] $proxy_cache_path          = undef,
  Optional[Integer] $proxy_cache_loader_files                = undef,
  Optional[String] $proxy_cache_loader_sleep                 = undef,
  Optional[String] $proxy_cache_loader_threshold             = undef,
  Optional[Enum['on', 'off']] $proxy_use_temp_path           = undef,
  $proxy_connect_timeout                                     = '90s',
  Integer $proxy_headers_hash_bucket_size                    = 64,
  Optional[String] $proxy_http_version                       = undef,
  $proxy_read_timeout                                        = '90s',
  $proxy_redirect                                            = undef,
  $proxy_send_timeout                                        = '90s',
  Array $proxy_set_header                                    = [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
    'Proxy ""',
  ],
  Array $proxy_hide_header                                   = [],
  Array $proxy_pass_header                                   = [],
  Array $proxy_ignore_header                                 = [],
  $sendfile                                                  = 'on',
  String $server_tokens                                      = 'on',
  $spdy                                                      = 'off',
  $http2                                                     = 'off',
  $ssl_stapling                                              = 'off',
  $types_hash_bucket_size                                    = '512',
  $types_hash_max_size                                       = '1024',
  Integer $worker_connections                                = 1024,
  Enum['on', 'off'] $ssl_prefer_server_ciphers               = 'on',
  Variant[Integer, Enum['auto']] $worker_processes           = 1,
  Integer $worker_rlimit_nofile                              = 1024,
  $ssl_protocols                                             = 'TLSv1 TLSv1.1 TLSv1.2',
  $ssl_ciphers                                               = 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS', # lint:ignore:140chars
  Optional[Stdlib::Unixpath] $ssl_dhparam                    = undef,

  ### START Package Configuration ###
  $package_ensure                                            = present,
  $package_name                                              = $nginx::params::package_name,
  $package_source                                            = 'nginx',
  $package_flavor                                            = undef,
  $manage_repo                                               = $nginx::params::manage_repo,
  Optional[String] $repo_release                             = undef,
  $passenger_package_ensure                                  = 'present',
  ### END Package Configuration ###

  ### START Service Configuation ###
  $service_ensure                                            = running,
  $service_enable                                            = true,
  $service_flags                                             = undef,
  $service_restart                                           = undef,
  $service_name                                              = 'nginx',
  $service_manage                                            = true,
  ### END Service Configuration ###

  ### START Hiera Lookups ###
  $geo_mappings                                              = {},
  $string_mappings                                           = {},
  $nginx_locations                                           = {},
  $nginx_locations_defaults                                  = {},
  $nginx_mailhosts                                           = {},
  $nginx_mailhosts_defaults                                  = {},
  $nginx_streamhosts                                         = {},
  $nginx_upstreams                                           = {},
  $nginx_servers                                             = {},
  $nginx_servers_defaults                                    = {},
  Boolean $purge_passenger_repo                              = true,
  Boolean $add_listen_directive                              = $nginx::params::add_listen_directive,
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
