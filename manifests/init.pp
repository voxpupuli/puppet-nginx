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
  $package_name           = $nginx::params::package_name,
  $package_ensure         = $nginx::params::package_ensure,
  $package_source         = $nginx::params::package_source,
  $proxy_set_header       = $nginx::params::nx_proxy_set_header,
  $proxy_http_version     = $nginx::params::nx_proxy_http_version,
  $confd_purge            = $nginx::params::nx_confd_purge,
  $proxy_cache_path       = $nginx::params::nx_proxy_cache_path,
  $proxy_cache_levels     = $nginx::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone  = $nginx::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size   = $nginx::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive   = $nginx::params::nx_proxy_cache_inactive,
  $configtest_enable      = $nginx::params::nx_configtest_enable,
  $service_restart        = $nginx::params::nx_service_restart,
  $mail                   = $nginx::params::nx_mail,
  $server_tokens          = $nginx::params::nx_server_tokens,
  $client_max_body_size   = $nginx::params::nx_client_max_body_size,
  $proxy_buffers          = $nginx::params::nx_proxy_buffers,
  $proxy_buffer_size      = $nginx::params::nx_proxy_buffer_size,
  $http_cfg_append        = $nginx::params::nx_http_cfg_append,
  $nginx_error_log        = $nginx::params::nx_nginx_error_log,
  $http_access_log        = $nginx::params::nx_http_access_log,
  $nginx_vhosts           = {},
  $nginx_upstreams        = {},
  $nginx_locations        = {},
  $manage_repo            = $nginx::params::manage_repo,
) inherits nginx::params {

  include stdlib

  class { 'nginx::package':
    package_name   => $package_name,
    package_source => $package_source,
    package_ensure => $package_ensure,
    notify      => Class['nginx::service'],
    manage_repo => $manage_repo,
  }

  class { 'nginx::config':
    worker_processes      => $worker_processes,
    worker_connections    => $worker_connections,
    proxy_set_header      => $proxy_set_header,
    proxy_http_version    => $proxy_http_version,
    proxy_cache_path      => $proxy_cache_path,
    proxy_cache_levels    => $proxy_cache_levels,
    proxy_cache_keys_zone => $proxy_cache_keys_zone,
    proxy_cache_max_size  => $proxy_cache_max_size,
    proxy_cache_inactive  => $proxy_cache_inactive,
    confd_purge           => $confd_purge,
    server_tokens         => $server_tokens,
    client_max_body_size  => $client_max_body_size,
    proxy_buffers         => $proxy_buffers,
    proxy_buffer_size     => $proxy_buffer_size,
    http_cfg_append       => $http_cfg_append,
    nginx_error_log       => $nginx_error_log,
    http_access_log       => $http_access_log,
    require               => Class['nginx::package'],
    notify                => Class['nginx::service'],
  }

  class { 'nginx::service':
    configtest_enable => $configtest_enable,
    service_restart   => $service_restart,
  }

  validate_hash($nginx_upstreams)
  create_resources('nginx::resource::upstream', $nginx_upstreams)
  validate_hash($nginx_vhosts)
  create_resources('nginx::resource::vhost', $nginx_vhosts)
  validate_hash($nginx_locations)
  create_resources('nginx::resource::location', $nginx_locations)

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
