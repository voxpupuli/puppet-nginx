# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the nginx::params class
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
  $temp_dir                = $nginx::params::nx_temp_dir,
  $run_dir                 = $nginx::params::nx_run_dir,
  $conf_dir                = $nginx::params::nx_conf_dir,
  $confd_purge             = $nginx::params::nx_confd_purge,
  $worker_processes        = $nginx::params::nx_worker_processes,
  $worker_connections      = $nginx::params::nx_worker_connections,
  $types_hash_max_size     = $nginx::params::nx_types_hash_max_size,
  $types_hash_bucket_size  = $nginx::params::nx_types_hash_bucket_size,
  $names_hash_bucket_size  = $nginx::params::nx_names_hash_bucket_size,
  $multi_accept            = $nginx::params::nx_multi_accept,
  $events_use              = $nginx::params::nx_events_use,
  $sendfile                = $nginx::params::nx_sendfile,
  $keepalive_timeout       = $nginx::params::nx_keepalive_timeout,
  $tcp_nodelay             = $nginx::params::nx_tcp_nodelay,
  $tcp_nopush              = $nginx::params::nx_tcp_nopush,
  $gzip                    = $nginx::params::nx_gzip,
  $server_tokens           = $nginx::params::nx_server_tokens,
  $spdy                    = $nginx::params::nx_spdy,
  $ssl_stapling            = $nginx::params::nx_ssl_stapling,
  $proxy_redirect          = $nginx::params::nx_proxy_redirect,
  $proxy_set_header        = $nginx::params::nx_proxy_set_header,
  $proxy_cache_path        = $nginx::params::nx_proxy_cache_path,
  $proxy_cache_levels      = $nginx::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone   = $nginx::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size    = $nginx::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive    = $nginx::params::nx_proxy_cache_inactive,
  $client_body_temp_path   = $nginx::params::nx_client_body_temp_path,
  $client_body_buffer_size = $nginx::params::nx_client_body_buffer_size,
  $client_max_body_size    = $nginx::params::nx_client_max_body_size,
  $proxy_temp_path         = $nginx::params::nx_proxy_temp_path,
  $proxy_connect_timeout   = $nginx::params::nx_proxy_connect_timeout,
  $proxy_send_timeout      = $nginx::params::nx_proxy_send_timeout,
  $proxy_read_timeout      = $nginx::params::nx_proxy_read_timeout,
  $proxy_buffers           = $nginx::params::nx_proxy_buffers,
  $proxy_http_version      = $nginx::params::nx_proxy_http_version,
  $logdir                  = $nginx::params::nx_logdir,
  $pid                     = $nginx::params::nx_pid,
  $daemon_user             = $nginx::params::nx_daemon_user,
  $configtest_enable       = $nginx::params::nx_configtest_enable,
  $service_restart         = $nginx::params::nx_service_restart,
  $mail                    = $nginx::params::nx_mail
) inherits nginx::params {

  include stdlib

  class { 'nginx::package':
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    worker_processes       => $worker_processes,
    worker_connections     => $worker_connections,
    confd_purge            => $confd_purge,
    server_tokens          => $server_tokens,
    proxy_set_header       => $proxy_set_header,
    proxy_cache_path       => $proxy_cache_path,
    proxy_cache_levels     => $proxy_cache_levels,
    proxy_cache_keys_zone  => $proxy_cache_keys_zone,
    proxy_cache_max_size   => $proxy_cache_max_size,
    proxy_cache_inactive   => $proxy_cache_inactive,
    proxy_http_version     => $proxy_http_version,
    types_hash_max_size    => $types_hash_max_size,
    types_hash_bucket_size => $types_hash_bucket_size,
    require                => Class['nginx::package'],
    notify                 => Class['nginx::service'],
  }

  class { 'nginx::service':
    configtest_enable => $configtest_enable,
    service_restart   => $service_restart,
  }

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'nginx::begin':
    before => Class['nginx::package'],
    notify => Class['nginx::service'],
  }
  anchor { 'nginx::end':
    require => Class['nginx::service'],
  }
}
