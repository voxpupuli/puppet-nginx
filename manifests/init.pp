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
  $worker_processes       = $nginx::params::nx_worker_processes,
  $worker_connections     = $nginx::params::nx_worker_connections,
  $confd_purge            = $nginx::params::nx_confd_purge,
  $proxy_redirect         = $nginx::params::nx_proxy_redirect,
  $proxy_set_header       = $nginx::params::nx_proxy_set_header,
  $proxy_cache_path       = $nginx::params::nx_proxy_cache_path,
  $proxy_cache_levels     = $nginx::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone  = $nginx::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size   = $nginx::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive   = $nginx::params::nx_proxy_cache_inactive,
  $proxy_connect_timeout  = $nginx::params::nx_proxy_connect_timeout,
  $proxy_send_timeout     = $nginx::params::nx_proxy_send_timeout,
  $proxy_read_timeout     = $nginx::params::nx_proxy_read_timeout,
  $proxy_buffers          = $nginx::params::nx_proxy_buffers,
  $proxy_http_version     = $nginx::params::nx_proxy_http_version,
  $configtest_enable      = $nginx::params::nx_configtest_enable,
  $service_restart        = $nginx::params::nx_service_restart,
  $mail                   = $nginx::params::nx_mail,
  $server_tokens          = $nginx::params::nx_server_tokens,
  $logdir                 = $nginx::params::nx_logdir,
  $pkg_version            = $nginx::params::nx_pkg_version
) inherits nginx::params {

  include stdlib

  class { 'nginx::package':
    pkg_version => $pkg_version,
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    worker_processes      => $worker_processes,
    worker_connections    => $worker_connections,
    proxy_redirect       => $proxy_redirect,
    proxy_set_header      => $proxy_set_header,
    proxy_cache_path      => $proxy_cache_path,
    proxy_cache_levels    => $proxy_cache_levels,
    proxy_cache_keys_zone => $proxy_cache_keys_zone,
    proxy_cache_max_size  => $proxy_cache_max_size,
    proxy_cache_inactive  => $proxy_cache_inactive,
    proxy_connect_timeout => $proxy_connect_timeout,
    proxy_send_timeout    => $proxy_send_timeout,
    proxy_read_timeout    => $proxy_read_timeout,
    proxy_buffers         => $proxy_buffers,
    proxy_http_version    => $proxy_http_version,
    confd_purge           => $confd_purge,
    logdir                => $logdir,
    require               => Class['nginx::package'],
    notify                => Class['nginx::service'],
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
