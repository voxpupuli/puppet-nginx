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
  # Clean up old resources from days long past
  include nginx::tombstone

  ###
  ### Validations
  ###

  # TODO: Add validations for all data types coming in

  ###
  ### Resources
  ###

  # Used to receive refresh events from resources.
  anchor { 'nginx::config': }

  file { $conf_dir:
    ensure => directory,
    owner  => $global_owner,
    group  => $global_group,
    mode   => $global_mode,
  }

  file { "${conf_dir}/conf.d":
    ensure => directory,
    owner  => $global_owner,
    group  => $global_group,
    mode   => $global_mode,
  }

  if $confd_purge == true {
    File["${conf_dir}/conf.d"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/conf.mail.d":
    ensure => directory,
    owner  => $global_owner,
    group  => $global_group,
    mode   => $global_mode,
  }

  if $confd_purge == true {
    File["${conf_dir}/conf.mail.d"] {
      purge   => true,
      recurse => true,
    }
  }

  file { $run_dir:
    ensure => directory,
    owner  => $global_owner,
    group  => $global_group,
    mode   => $global_mode,
  }

  file { $client_body_temp_path:
    ensure => directory,
    owner  => $daemon_user,
    group  => $global_group,
    mode   => $global_mode,
  }

  file { $proxy_temp_path:
    ensure => directory,
    owner  => $daemon_user,
    group  => $global_group,
    mode   => $global_mode,
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
    owner  => $global_owner,
    group  => $global_group,
    mode   => $global_mode,
  }

  if $vhost_purge == true {
    File["${conf_dir}/sites-enabled"] {
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/nginx.conf":
    ensure  => file,
    owner   => $global_owner,
    group   => $global_group,
    mode    => $global_mode,
    content => template($conf_template),
  }

  file { "${conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    owner   => $global_owner,
    group   => $global_group,
    mode    => $global_mode,
    content => template($proxy_conf_template),
  }
}
