# Class: nginx::config
#
# This module manages NGINX bootstrap and configuration
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::config(
  $client_body_buffer_size        = undef,
  $client_body_temp_path          = undef,
  $client_max_body_size           = undef,
  $confd_purge                    = undef,
  $conf_dir                       = undef,
  $conf_template                  = undef,
  $daemon_user                    = undef,
  $events_use                     = undef,
  $fastcgi_cache_inactive         = undef,
  $fastcgi_cache_key              = undef,
  $fastcgi_cache_keys_zone        = undef,
  $fastcgi_cache_levels           = undef,
  $fastcgi_cache_max_size         = undef,
  $fastcgi_cache_path             = undef,
  $fastcgi_cache_use_stale        = undef,
  $gzip                           = undef,
  $http_access_log                = undef,
  $http_cfg_append                = undef,
  $http_tcp_nodelay               = undef,
  $http_tcp_nopush                = undef,
  $keepalive_timeout              = undef,
  $logdir                         = undef,
  $mail                           = undef,
  $multi_accept                   = undef,
  $names_hash_bucket_size         = undef,
  $names_hash_max_size            = undef,
  $nginx_error_log                = undef,
  $pid                            = undef,
  $proxy_buffers                  = undef,
  $proxy_buffer_size              = undef,
  $proxy_cache_inactive           = undef,
  $proxy_cache_keys_zone          = undef,
  $proxy_cache_levels             = undef,
  $proxy_cache_max_size           = undef,
  $proxy_cache_path               = undef,
  $proxy_conf_template            = undef,
  $proxy_connect_timeout          = undef,
  $proxy_headers_hash_bucket_size = undef,
  $proxy_http_version             = undef,
  $proxy_read_timeout             = undef,
  $proxy_redirect                 = undef,
  $proxy_send_timeout             = undef,
  $proxy_set_header               = undef,
  $proxy_temp_path                = undef,
  $root_group                     = undef,
  $run_dir                        = undef,
  $sendfile                       = undef,
  $server_tokens                  = undef,
  $spdy                           = undef,
  $super_user                     = undef,
  $temp_dir                       = undef,
  $types_hash_bucket_size         = undef,
  $types_hash_max_size            = undef,
  $vhost_purge                    = undef,
  $worker_connections             = undef,
  $worker_processes               = undef,
  $worker_rlimit_nofile           = undef,
  $global_owner                   = undef,
  $global_group                   = undef,
  $global_mode                    = undef,
  $sites_available_owner          = undef,
  $sites_available_group          = undef,
  $sites_available_mode           = undef,
) {

  ### Validations ###
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
  validate_array($proxy_set_header)
  validate_string($proxy_http_version)
  validate_bool($confd_purge)
  validate_bool($vhost_purge)
  if ($proxy_cache_path != false) {
    validate_string($proxy_cache_path)
  }
  validate_re($proxy_cache_levels, '^[12](:[12])*$')
  validate_string($proxy_cache_keys_zone)
  validate_string($proxy_cache_max_size)
  validate_string($proxy_cache_inactive)

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
  validate_string($proxy_headers_hash_bucket_size)
  validate_bool($super_user)

  ### END VALIDATIONS ###


  ### CONFIGURATION ###
  File {
    owner => $global_owner,
    group => $global_group,
    mode  => $global_mode,
  }

  file { $conf_dir:
    ensure => directory,
  }

  file { "${conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${conf_dir}/conf.d"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/conf.mail.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${conf_dir}/conf.mail.d"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/conf.d/vhost_autogen.conf":
    ensure => absent,
  }

  file { "${conf_dir}/conf.mail.d/vhost_autogen.conf":
    ensure => absent,
  }

  file {$run_dir:
    ensure => directory,
  }

  file {$client_body_temp_path:
    ensure => directory,
    owner  => $daemon_user,
  }

  file {$proxy_temp_path:
    ensure => directory,
    owner  => $daemon_user,
  }

  file { "${conf_dir}/sites-available":
    ensure => directory,
    owner  => $sites_available_owner,
    group  => $sites_available_group,
    mode   => $sites_available_mode,
  }

  if $vhost_purge == true {
    File["${conf_dir}/sites-available"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/sites-enabled":
    ensure => directory,
  }

  if $vhost_purge == true {
    File["${conf_dir}/sites-enabled"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/sites-enabled/default":
    ensure => absent,
  }

  file { "${conf_dir}/nginx.conf":
    ensure  => file,
    content => template($conf_template),
  }

  file { "${conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    content => template($proxy_conf_template),
  }

  file { "${conf_dir}/conf.d/default.conf":
    ensure => absent,
  }

  file { "${conf_dir}/conf.d/example_ssl.conf":
    ensure => absent,
  }

  file { "${temp_dir}/nginx.d":
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { "${temp_dir}/nginx.mail.d":
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }
}
