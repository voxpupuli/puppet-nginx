# @summary Manage NGINX
#
# Packaged NGINX
#   - RHEL: EPEL or custom package
#   - Debian/Ubuntu: Default Install or custom package
#   - SuSE: Default Install or custom package
#
# @example Use the sensible defaults
#   include nginx
#
# @param include_modules_enabled
#   When set, nginx will include module configurations files installed in the
#   /etc/nginx/modules-enabled directory.
#
# @param passenger_package_name
#   The name of the package to install in order for the passenger module of
#   nginx being usable.
#
# @param nginx_version
#   The version of nginx installed (or being installed).
#   Unfortunately, different versions of nginx may need configuring
#   differently.  The default is derived from the version of nginx
#   already installed.  If the fact is unavailable, it defaults to '1.6.0'.
#   You may need to set this manually to get a working and idempotent
#   configuration.
#
# @param debug_connections
#   Configures nginx `debug_connection` lines in the `events` section of the nginx config.
#   See http://nginx.org/en/docs/ngx_core_module.html#debug_connection
#
# @param service_config_check
#  whether to en- or disable the config check via nginx -t on config changes
#
# @param service_config_check_command
#  Command to execute to validate the generated configuration.
#
# @param reset_timedout_connection
#   Enables or disables resetting timed out connections and connections closed
#   with the non-standard code 444.
#
# @param nginx_snippets
#   Specifies a hash from which to generate `nginx::resource::snippet` resources.
#
# @param nginx_snippets_defaults
#   Can be used to define default values for the parameter `nginx_snippets`.
#
class nginx (
  ### START Nginx Configuration ###
  Optional[Variant[Stdlib::Absolutepath, Tuple[Stdlib::Absolutepath, Integer, 1, 4]]] $client_body_temp_path      = undef,
  Boolean $confd_only                                        = false,
  Boolean $confd_purge                                       = false,
  Stdlib::Absolutepath $conf_dir                             = $nginx::params::conf_dir,
  Optional[Enum['on', 'off']] $daemon                        = undef,
  String[1] $daemon_user                                     = $nginx::params::daemon_user,
  Optional[String[1]] $daemon_group                          = undef,
  Array[String] $dynamic_modules                             = [],
  String[1] $global_owner                                    = 'root',
  String[1] $global_group                                    = $nginx::params::global_group,
  Stdlib::Filemode $global_mode                              = '0644',
  Optional[Variant[String[1], Array[String[1]]]] $limit_req_zone = undef,
  Stdlib::Absolutepath $log_dir                              = $nginx::params::log_dir,
  Boolean $manage_log_dir                                    = true,
  String[1] $log_user                                        = $nginx::params::log_user,
  String[1] $log_group                                       = $nginx::params::log_group,
  Stdlib::Filemode $log_mode                                 = $nginx::params::log_mode,
  Variant[String, Array[String]] $http_access_log            = "${log_dir}/access.log",
  Optional[String] $http_format_log                          = undef,
  Variant[String, Array[String]] $stream_access_log          = "${log_dir}/stream-access.log",
  Optional[String] $stream_custom_format_log                 = undef,
  Variant[String, Array[String]] $nginx_error_log            = "${log_dir}/error.log",
  Nginx::ErrorLogSeverity $nginx_error_log_severity          = 'error',
  Variant[Stdlib::Absolutepath,Boolean] $pid                 = $nginx::params::pid,
  Optional[Variant[Stdlib::Absolutepath, Tuple[Stdlib::Absolutepath, Integer, 1, 4]]] $proxy_temp_path = undef,
  String[1] $root_group                                      = $nginx::params::root_group,
  String[1] $sites_available_owner                           = 'root',
  String[1] $sites_available_group                           = $nginx::params::sites_available_group,
  Stdlib::Filemode $sites_available_mode                     = '0644',
  Boolean $super_user                                        = true,
  Stdlib::Absolutepath $temp_dir                             = '/tmp',
  Boolean $server_purge                                      = false,
  Boolean $include_modules_enabled                           = $nginx::params::include_modules_enabled,

  # Primary Templates
  String[1] $conf_template                                   = 'nginx/conf.d/nginx.conf.erb',
  String[1] $fastcgi_conf_template                           = 'nginx/server/fastcgi.conf.erb',
  String[1] $uwsgi_params_template                           = 'nginx/server/uwsgi_params.erb',

  ### START Nginx Configuration ###
  Optional[Enum['on', 'off']] $absolute_redirect             = undef,
  Enum['on', 'off'] $accept_mutex                            = 'on',
  Nginx::Time $accept_mutex_delay                            = '500ms',
  Nginx::Size $client_body_buffer_size                       = '128k',
  Nginx::Size $client_max_body_size                          = '10m',
  Nginx::Time $client_body_timeout                           = '60s',
  Nginx::Time $send_timeout                                  = '60s',
  Nginx::Time $lingering_timeout                             = '5s',
  Optional[Enum['on','off','always']] $lingering_close       = undef,
  Optional[String[1]] $lingering_time                        = undef,
  Optional[Enum['on', 'off']] $etag                          = undef,
  Optional[String] $events_use                               = undef,
  Array[Nginx::DebugConnection] $debug_connections           = [],
  Nginx::Time $fastcgi_cache_inactive                        = '20m',
  Optional[String] $fastcgi_cache_key                        = undef,
  String $fastcgi_cache_keys_zone                            = 'd3:100m',
  String $fastcgi_cache_levels                               = '1',
  Nginx::Size $fastcgi_cache_max_size                        = '500m',
  Optional[String] $fastcgi_cache_path                       = undef,
  Optional[String] $fastcgi_cache_use_stale                  = undef,
  Enum['on', 'off'] $gzip                                    = 'off',
  Optional[String] $gzip_buffers                             = undef,
  Integer $gzip_comp_level                                   = 1,
  String $gzip_disable                                       = 'msie6',
  Integer $gzip_min_length                                   = 20,
  Enum['1.0','1.1'] $gzip_http_version                       = '1.1',
  Variant[Nginx::GzipProxied, Array[Nginx::GzipProxied]] $gzip_proxied = 'off',
  Optional[Variant[String[1],Array[String[1]]]] $gzip_types  = undef,
  Enum['on', 'off'] $gzip_vary                               = 'off',
  Optional[Enum['on', 'off', 'always']] $gzip_static         = undef,
  Optional[Variant[Hash, Array]] $http_cfg_prepend           = undef,
  Optional[Variant[Hash, Array]] $http_cfg_append            = undef,
  Optional[Variant[Array[String], String]] $http_raw_prepend = undef,
  Optional[Variant[Array[String], String]] $http_raw_append  = undef,
  Enum['on', 'off'] $http_tcp_nodelay                        = 'on',
  Enum['on', 'off'] $http_tcp_nopush                         = 'off',
  Nginx::Time $keepalive_timeout                             = '65s',
  Integer $keepalive_requests                                = 100,
  Hash[String[1], Nginx::LogFormat] $log_format              = {},
  Hash[String[1], Nginx::LogFormat] $stream_log_format       = {},
  Boolean $mail                                              = false,
  Optional[Integer] $map_hash_bucket_size                    = undef,
  Optional[Integer] $map_hash_max_size                       = undef,
  Variant[String, Boolean] $mime_types_path                  = 'mime.types',
  Boolean $stream                                            = false,
  String $multi_accept                                       = 'off',
  Integer $names_hash_bucket_size                            = 64,
  Integer $names_hash_max_size                               = 512,
  Variant[Boolean,Array,Hash] $nginx_cfg_prepend             = false,
  String $proxy_buffers                                      = '32 4k',
  Nginx::Size $proxy_buffer_size                             = '8k',
  Nginx::Time $proxy_cache_inactive                          = '20m',
  String $proxy_cache_keys_zone                              = 'd2:100m',
  String $proxy_cache_levels                                 = '1',
  Nginx::Size $proxy_cache_max_size                          = '500m',
  Optional[Variant[Hash, String]] $proxy_cache_path          = undef,
  Optional[Integer] $proxy_cache_loader_files                = undef,
  Optional[String] $proxy_cache_loader_sleep                 = undef,
  Optional[String] $proxy_cache_loader_threshold             = undef,
  Optional[Enum['on', 'off']] $proxy_use_temp_path           = undef,
  Nginx::Time $proxy_connect_timeout                         = '90s',
  Integer $proxy_headers_hash_bucket_size                    = 64,
  Optional[String] $proxy_http_version                       = undef,
  Nginx::Time $proxy_read_timeout                            = '90s',
  Optional[String] $proxy_redirect                           = undef,
  Nginx::Time $proxy_send_timeout                            = '90s',
  Array $proxy_set_header                                    = [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
    'X-Forwarded-Host $host',
    'X-Forwarded-Proto $scheme',
    'Proxy ""',
  ],
  Array $proxy_hide_header                                   = [],
  Array $proxy_pass_header                                   = [],
  Array $proxy_ignore_header                                 = [],
  Optional[Nginx::Size] $proxy_max_temp_file_size            = undef,
  Optional[Nginx::Size] $proxy_busy_buffers_size             = undef,
  Enum['on', 'off'] $sendfile                                = 'on',
  Enum['on', 'off'] $server_tokens                           = 'on',
  Enum['on', 'off'] $spdy                                    = 'off',
  Enum['on', 'off'] $http2                                   = 'off',
  Enum['on', 'off'] $ssl_stapling                            = 'off',
  Enum['on', 'off'] $ssl_stapling_verify                     = 'off',
  Stdlib::Absolutepath $snippets_dir                         = $nginx::params::snippets_dir,
  Boolean $manage_snippets_dir                               = true,
  Variant[Integer,String] $types_hash_bucket_size            = '512',
  Variant[Integer,String] $types_hash_max_size               = '1024',
  Integer $worker_connections                                = 1024,
  Enum['on', 'off'] $ssl_prefer_server_ciphers               = 'on',
  Variant[Integer, Enum['auto']] $worker_processes           = 'auto',
  Integer $worker_rlimit_nofile                              = 1024,
  Optional[Enum['on', 'off']] $pcre_jit                      = undef,
  String $ssl_protocols                                      = 'TLSv1 TLSv1.1 TLSv1.2',
  String $ssl_ciphers                                        = 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS', # lint:ignore:140chars
  Optional[Stdlib::Unixpath] $ssl_dhparam                    = undef,
  Optional[String] $ssl_ecdh_curve                           = undef,
  String $ssl_session_cache                                  = 'shared:SSL:10m',
  Nginx::Time $ssl_session_timeout                           = '5m',
  Optional[Enum['on', 'off']] $ssl_session_tickets           = undef,
  Optional[Stdlib::Absolutepath] $ssl_session_ticket_key     = undef,
  Optional[String] $ssl_buffer_size                          = undef,
  Optional[Stdlib::Absolutepath] $ssl_crl                    = undef,
  Optional[Stdlib::Absolutepath] $ssl_stapling_file          = undef,
  Optional[String] $ssl_stapling_responder                   = undef,
  Optional[Stdlib::Absolutepath] $ssl_trusted_certificate    = undef,
  Optional[Integer] $ssl_verify_depth                        = undef,
  Optional[Stdlib::Absolutepath] $ssl_password_file          = undef,
  Optional[Enum['on', 'off']] $reset_timedout_connection     = undef,

  ### START Package Configuration ###
  String $package_ensure                                     = installed,
  String $package_name                                       = $nginx::params::package_name,
  Nginx::Package_source $package_source                      = 'nginx',
  Optional[String] $package_flavor                           = undef,
  Boolean $manage_repo                                       = $nginx::params::manage_repo,
  Hash[String[1], String[1]] $mime_types                     = $nginx::params::mime_types,
  Boolean $mime_types_preserve_defaults                      = false,
  Optional[String] $repo_release                             = undef,
  String $passenger_package_ensure                           = installed,
  String[1] $passenger_package_name                          = $nginx::params::passenger_package_name,
  Optional[Stdlib::HTTPUrl] $repo_source                     = undef,
  ### END Package Configuration ###

  ### START Service Configuation ###
  Stdlib::Ensure::Service $service_ensure                    = 'running',
  Boolean $service_enable                                    = true,
  Optional[String] $service_flags                            = undef,
  Optional[String] $service_restart                          = undef,
  String $service_name                                       = 'nginx',
  Boolean $service_manage                                    = true,
  Boolean $service_config_check                              = false,
  String $service_config_check_command                       = 'nginx -t',
  ### END Service Configuration ###

  ### START Hiera Lookups ###
  Hash $geo_mappings                                      = {},
  Hash $geo_mappings_defaults                             = {},
  Hash $string_mappings                                   = {},
  Hash $string_mappings_defaults                          = {},
  Hash $nginx_snippets                                    = {},
  Hash $nginx_snippets_defaults                           = {},
  Hash $nginx_locations                                   = {},
  Hash $nginx_locations_defaults                          = {},
  Hash $nginx_mailhosts                                   = {},
  Hash $nginx_mailhosts_defaults                          = {},
  Hash $nginx_servers                                     = {},
  Hash $nginx_servers_defaults                            = {},
  Hash $nginx_streamhosts                                 = {},
  Hash $nginx_streamhosts_defaults                        = {},
  Hash $nginx_upstreams                                   = {},
  Nginx::UpstreamDefaults $nginx_upstreams_defaults       = {},
  Boolean $purge_passenger_repo                           = true,
  String[1] $nginx_version                                = pick(fact('nginx_version'), '1.16.0'),

  ### END Hiera Lookups ###
) inherits nginx::params {
  contain 'nginx::package'
  contain 'nginx::config'
  contain 'nginx::service'

  create_resources( 'nginx::resource::geo', $geo_mappings, $geo_mappings_defaults )
  create_resources( 'nginx::resource::snippet', $nginx_snippets, $nginx_snippets_defaults )
  create_resources( 'nginx::resource::location', $nginx_locations, $nginx_locations_defaults )
  create_resources( 'nginx::resource::mailhost', $nginx_mailhosts, $nginx_mailhosts_defaults )
  create_resources( 'nginx::resource::map', $string_mappings, $string_mappings_defaults )
  create_resources( 'nginx::resource::server', $nginx_servers, $nginx_servers_defaults )
  create_resources( 'nginx::resource::streamhost', $nginx_streamhosts, $nginx_streamhosts_defaults )
  create_resources( 'nginx::resource::upstream', $nginx_upstreams, $nginx_upstreams_defaults )

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  Class['nginx::package'] -> Class['nginx::config'] ~> Class['nginx::service']
  Class['nginx::package'] ~> Class['nginx::service']
}
