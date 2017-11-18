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
  Stdlib::Absolutepath $client_body_temp_path,
  Boolean $confd_only,
  Boolean $confd_purge,
  Stdlib::Absolutepath $conf_dir,
  Optional[Enum['on', 'off']] $daemon                        = undef,
  String $daemon_user,
  Optional[String] $daemon_group,
  String $global_owner,
  String $global_group,
  String $global_mode,
  Stdlib::Absolutepath $log_dir,
  String $log_group,
  String $log_mode,
  Variant[String, Array[String]] $http_access_log            = "${log_dir}/access.log",
  Optional[String] $http_format_log                          = undef,
  Variant[String, Array[String]] $nginx_error_log            = "${log_dir}/error.log",
  Nginx::ErrorLogSeverity $nginx_error_log_severity,
  Variant[Stdlib::Absolutepath, Boolean] $pid,
  Stdlib::Absolutepath $proxy_temp_path,
  String $root_group,
  Stdlib::Absolutepath $run_dir,
  String $sites_available_owner,
  String $sites_available_group,
  String $sites_available_mode,
  Boolean $super_user,
  Stdlib::Absolutepath $temp_dir,
  Boolean $server_purge,

  # Primary Templates
  $conf_template,

  ### START Nginx Configuration ###
  Enum['on', 'off'] $accept_mutex,
  String $accept_mutex_delay,
  String $client_body_buffer_size,
  String $client_max_body_size,
  String $client_body_timeout,
  String $send_timeout,
  String $lingering_timeout,
  Optional[Enum['on', 'off']] $etag                          = undef,
  Optional[String] $events_use                               = undef,
  String $fastcgi_cache_inactive                             = '20m',
  Optional[String] $fastcgi_cache_key                        = undef,
  String $fastcgi_cache_keys_zone                            = 'd3:100m',
  String $fastcgi_cache_levels                               = '1',
  String $fastcgi_cache_max_size                             = '500m',
  Optional[String] $fastcgi_cache_path                       = undef,
  Optional[String] $fastcgi_cache_use_stale                  = undef,
  Enum['on', 'off'] $gzip                                    = 'on',
  $gzip_buffers                                              = undef,
  $gzip_comp_level                                           = 1,
  $gzip_disable                                              = 'msie6',
  $gzip_min_length                                           = 20,
  $gzip_http_version                                         = 1.1,
  $gzip_proxied                                              = 'off',
  $gzip_types                                                = undef,
  Enum['on', 'off'] $gzip_vary                               = 'off',
  Optional[Variant[Hash, Array]] $http_cfg_prepend           = undef,
  Optional[Variant[Hash, Array]] $http_cfg_append            = undef,
  Optional[Variant[Array[String], String]] $http_raw_prepend = undef,
  Optional[Variant[Array[String], String]] $http_raw_append  = undef,
  Enum['on', 'off'] $http_tcp_nodelay                        = 'on',
  Enum['on', 'off'] $http_tcp_nopush                         = 'off',
  $keepalive_timeout                                         = '65s',
  $keepalive_requests                                        = '100',
  $log_format                                                = {},
  Boolean $mail                                              = false,
  Boolean $stream                                            = false,
  Enum['on', 'off'] $multi_accept                            = 'off',
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
  Enum['on', 'off'] $sendfile                                = 'on',
  Enum['on', 'off'] $server_tokens                           = 'on',
  $spdy                                                      = 'off',
  $http2                                                     = 'off',
  Enum['on', 'off'] $ssl_stapling                            = 'off',
  $types_hash_bucket_size                                    = '512',
  $types_hash_max_size                                       = '1024',
  Integer $worker_connections                                = 1024,
  Enum['on', 'off'] $ssl_prefer_server_ciphers               = 'on',
  Variant[Integer, Enum['auto']] $worker_processes           = 1,
  Integer $worker_rlimit_nofile                              = 1024,
  String $ssl_protocols,
  String $ssl_ciphers,
  Optional[Stdlib::Unixpath] $ssl_dhparam                    = undef,

  ### START Package Configuration ###
  String $package_ensure,
  String $package_name,
  String $package_source,
  Optional[String] $package_flavor                           = undef,
  Boolean $manage_repo,
  String $passenger_package_ensure,
  ### END Package Configuration ###

  ### START Service Configuation ###
  Enum['running', 'stopped'] $service_ensure,
  Optional[String] $service_flags                            = undef,
  Optional[String] $service_restart                          = undef,
  String $service_name,
  Boolean $service_manage,
  ### END Service Configuration ###

  ### START Hiera Lookups ###
  Hash[String, Any] $geo_mappings                            = {},
  Hash[String, Any] $string_mappings                         = {},
  Hash[String, Any] $nginx_locations                         = {},
  Hash[String, Any] $nginx_locations_defaults                = {},
  Hash[String, Any] $nginx_mailhosts                         = {},
  Hash[String, Any] $nginx_mailhosts_defaults                = {},
  Hash[String, Any] $nginx_streamhosts                       = {},
  Hash[String, Any] $nginx_upstreams                         = {},
  Hash[String, Any] $nginx_servers                           = {},
  Hash[String, Any] $nginx_servers_defaults                  = {},
  ### END Hiera Lookups ###
) {

  contain '::nginx::package'
  contain '::nginx::config'
  contain '::nginx::service'

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
  Class['::nginx::package'] -> Class['::nginx::config'] ~> Class['::nginx::service']
  Class['::nginx::package'] ~> Class['::nginx::service']
}
