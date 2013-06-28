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
  $client_body_buffer_size = $nginx::params::nx_client_body_buffer_size,
  $client_body_temp_path   = $nginx::params::nx_client_body_temp_path,
  $client_max_body_size    = $nginx::params::nx_client_max_body_size,
  $conf_dir                = $nginx::params::nx_conf_dir,
  $confd_purge             = $nginx::params::nx_confd_purge,
  $configtest_enable       = $nginx::params::nx_configtest_enable,
  $daemon_user             = $nginx::params::nx_daemon_user,
  $events_use              = $nginx::params::nx_events_use,
  $gzip                    = $nginx::params::nx_gzip,
  $keepalive_timeout       = $nginx::params::nx_keepalive_timeout,
  $mail                    = $nginx::params::nx_mail,
  $multi_accept            = $nginx::params::multi_accept,
  $names_hash_bucket_size  = $nginx::params::names_hash_bucket_size,
  $pid                     = $nginx::params::nx_pid,
  $proxy_buffers           = $nginx::params::nx_proxy_buffers,
  $proxy_cache_inactive    = $nginx::params::nx_proxy_cache_inactive,
  $proxy_cache_keys_zone   = $nginx::params::nx_proxy_cache_keys_zone,
  $proxy_cache_levels      = $nginx::params::nx_proxy_cache_levels,
  $proxy_cache_max_size    = $nginx::params::nx_proxy_cache_max_size,
  $proxy_cache_path        = $nginx::params::nx_proxy_cache_path,
  $proxy_connect_timeout   = $nginx::params::nx_proxy_connect_timeout,
  $proxy_http_version      = $nginx::params::nx_proxy_http_version,
  $proxy_read_timeout      = $nginx::params::nx_proxy_read_timeout,
  $proxy_redirect          = $nginx::params::nx_proxy_redirect,
  $proxy_send_timeout      = $nginx::params::nx_proxy_send_timeout,
  $proxy_set_header        = $nginx::params::nx_proxy_set_header,
  $proxy_temp_path         = $nginx::params::nx_proxy_temp_path,
  $run_dir                 = $nginx::params::nx_run_dir,
  $sendfile                = $nginx::params::nx_sendfile,
  $server_tokens           = $nginx::params::nx_server_tokens,
  $service_restart         = $nginx::params::nx_service_restart,
  $tcp_nodelay             = $nginx::params::nx_tcp_nodelay,
  $tcp_nopush              = $nginx::params::nx_tcp_nopush,
  $temp_dir                = $nginx::params::temp_dir,
  $types_hash_bucket_size  = $nginx::params::nx_types_hash_bucket_size,
  $types_hash_max_size     = $nginx::params::nx_types_hash_max_size,
  $worker_connections      = $nginx::params::nx_worker_connections,
  $worker_processes        = $nginx::params::nx_worker_processes,
) inherits nginx::params {

  include stdlib

  class { 'nginx::package':
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    confd_purge           => $confd_purge,
    notify                => Class['nginx::service'],
    proxy_cache_inactive  => $proxy_cache_inactive,
    proxy_cache_keys_zone => $proxy_cache_keys_zone,
    proxy_cache_levels    => $proxy_cache_levels,
    proxy_cache_max_size  => $proxy_cache_max_size,
    proxy_cache_path      => $proxy_cache_path,
    proxy_http_version    => $proxy_http_version,
    proxy_set_header      => $proxy_set_header,
    require               => Class['nginx::package'],
    worker_connections    => $worker_connections,
    worker_processes      => $worker_processes,
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
