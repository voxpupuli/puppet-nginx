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
  $client_body_buffer_size        = $nginx::client_body_buffer_size,
  $client_body_temp_path          = $nginx::client_body_temp_path,
  $client_max_body_size           = $nginx::client_max_body_size,
  $confd_purge                    = $nginx::confd_purge,
  $conf_dir                       = $nginx::conf_dir,
  $conf_template                  = $nginx::conf_template,
  $daemon_user                    = $nginx::daemon_user,
  $events_use                     = $nginx::events_use,
  $fastcgi_cache_inactive         = $nginx::fastcgi_cache_inactive,
  $fastcgi_cache_key              = $nginx::fastcgi_cache_key,
  $fastcgi_cache_keys_zone        = $nginx::fastcgi_cache_keys_zone,
  $fastcgi_cache_levels           = $nginx::fastcgi_cache_levels,
  $fastcgi_cache_max_size         = $nginx::fastcgi_cache_max_size,
  $fastcgi_cache_path             = $nginx::fastcgi_cache_path,
  $fastcgi_cache_use_stale        = $nginx::fastcgi_cache_use_stale,
  $gzip                           = $nginx::gzip,
  $http_access_log                = $nginx::http_access_log,
  $http_cfg_append                = $nginx::http_cfg_append,
  $http_tcp_nodelay               = $nginx::http_tcp_nodelay,
  $http_tcp_nopush                = $nginx::http_tcp_nopush,
  $keepalive_timeout              = $nginx::keepalive_timeout,
  $logdir                         = $nginx::logdir,
  $mail                           = $nginx::mail,
  $multi_accept                   = $nginx::multi_accept,
  $names_hash_bucket_size         = $nginx::names_hash_bucket_size,
  $names_hash_max_size            = $nginx::names_hash_max_size,
  $nginx_error_log                = $nginx::nginx_error_log,
  $pid                            = $nginx::pid,
  $proxy_buffers                  = $nginx::proxy_buffers,
  $proxy_buffer_size              = $nginx::proxy_buffer_size,
  $proxy_cache_inactive           = $nginx::proxy_cache_inactive,
  $proxy_cache_keys_zone          = $nginx::proxy_cache_keys_zone,
  $proxy_cache_levels             = $nginx::proxy_cache_levels,
  $proxy_cache_max_size           = $nginx::proxy_cache_max_size,
  $proxy_cache_path               = $nginx::proxy_cache_path,
  $proxy_conf_template            = $nginx::proxy_conf_template,
  $proxy_connect_timeout          = $nginx::proxy_connect_timeout,
  $proxy_headers_hash_bucket_size = $nginx::proxy_headers_hash_bucket_size,
  $proxy_http_version             = $nginx::proxy_http_version,
  $proxy_read_timeout             = $nginx::proxy_read_timeout,
  $proxy_redirect                 = $nginx::proxy_redirect,
  $proxy_send_timeout             = $nginx::proxy_send_timeout,
  $proxy_set_header               = $nginx::proxy_set_header,
  $proxy_temp_path                = $nginx::proxy_temp_path,
  $run_dir                        = $nginx::run_dir,
  $sendfile                       = $nginx::sendfile,
  $server_tokens                  = $nginx::server_tokens,
  $spdy                           = $nginx::spdy,
  $super_user                     = $nginx::super_user,
  $temp_dir                       = $nginx::temp_dir,
  $types_hash_bucket_size         = $nginx::types_hash_bucket_size,
  $types_hash_max_size            = $nginx::types_hash_max_size,
  $vhost_purge                    = $nginx::vhost_purge,
  $worker_connections             = $nginx::worker_connections,
  $worker_processes               = $nginx::worker_processes,
  $worker_rlimit_nofile           = $nginx::worker_rlimit_nofile,
  $global_owner                   = $nginx::global_owner,
  $global_group                   = $nginx::global_group,
  $global_mode                    = $nginx::global_mode,
  $sites_available_owner          = $nginx::sites_available_owner,
  $sites_available_group          = $nginx::sites_available_group,
  $sites_available_mode           = $nginx::sites_available_mode,
) inherits ::nginx {

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
    owner  => $sites_available_owner,
    group  => $sites_available_group,
    mode   => $sites_available_mode,
    ensure => directory,
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
