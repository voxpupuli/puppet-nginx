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
  $confd_purge            = $nginx::confd_purge,
  $proxy_cache_inactive   = $nginx::proxy_cache_inactive,
  $proxy_cache_keys_zone  = $nginx::proxy_cache_keys_zone,
  $proxy_cache_levels     = $nginx::proxy_cache_levels,
  $proxy_cache_max_size   = $nginx::proxy_cache_max_size,
  $proxy_cache_path       = $nginx::proxy_cache_path,
  $proxy_http_version     = $nginx::proxy_http_version,
  $proxy_set_header       = $nginx::proxy_set_header,
  $server_tokens          = $nginx::server_tokens,
  $types_hash_bucket_size = $nginx::types_hash_bucket_size,
  $types_hash_max_size    = $nginx::types_hash_max_size,
  $worker_connections     = $nginx::worker_connections,
  $worker_processes       = $nginx::worker_processes,
) inherits nginx {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $nginx::conf_dir:
    ensure => directory,
  }

  file { "${nginx::conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${nginx::conf_dir}/conf.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { "${nginx::conf_dir}/conf.mail.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${nginx::conf_dir}/conf.mail.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file {$nginx::run_dir:
    ensure => directory,
  }

  file {$nginx::client_body_temp_path:
    ensure => directory,
    owner  => $nginx::daemon_user,
  }

  file {$nginx::proxy_temp_path:
    ensure => directory,
    owner  => $nginx::daemon_user,
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
  }

  file { "${nginx::conf_dir}/nginx.conf":
    ensure  => file,
    content => template('nginx/conf.d/nginx.conf.erb'),
  }

  file { "${nginx::conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    content => template('nginx/conf.d/proxy.conf.erb'),
  }

  file { "${nginx::temp_dir}/nginx.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${nginx::temp_dir}/nginx.mail.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
}
