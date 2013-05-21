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
  $worker_processes       = $nginx::params::nx_worker_processes,
  $worker_connections     = $nginx::params::nx_worker_connections,
  $confd_purge            = $nginx::params::nx_confd_purge,
  $server_tokens          = $nginx::params::nx_server_tokens,
  $proxy_set_header       = $nginx::params::nx_proxy_set_header,
  $proxy_cache_path       = $nginx::params::nx_proxy_cache_path,
  $proxy_cache_levels     = $nginx::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone  = $nginx::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size   = $nginx::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive   = $nginx::params::nx_proxy_cache_inactive,
  $proxy_http_version     = $nginx::params::nx_proxy_http_version,
  $types_hash_max_size    = $nginx::params::nx_types_hash_max_size,
  $types_hash_bucket_size = $nginx::params::nx_types_hash_bucket_size
) inherits nginx::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $nginx::params::nx_conf_dir:
    ensure => directory,
  }

  file { "${nginx::params::nx_conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${nginx::params::nx_conf_dir}/conf.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { "${nginx::params::nx_conf_dir}/conf.mail.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${nginx::params::nx_conf_dir}/conf.mail.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file {$nginx::config::nx_run_dir:
    ensure => directory,
  }

  file {$nginx::config::nx_client_body_temp_path:
    ensure => directory,
    owner  => $nginx::params::nx_daemon_user,
  }

  file {$nginx::config::nx_proxy_temp_path:
    ensure => directory,
    owner  => $nginx::params::nx_daemon_user,
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
  }

  file { "${nginx::params::nx_conf_dir}/nginx.conf":
    ensure  => file,
    content => template('nginx/conf.d/nginx.conf.erb'),
  }

  file { "${nginx::params::nx_conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    content => template('nginx/conf.d/proxy.conf.erb'),
  }

  file { "${nginx::config::nx_temp_dir}/nginx.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${nginx::config::nx_temp_dir}/nginx.mail.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
}
