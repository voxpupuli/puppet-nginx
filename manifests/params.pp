# Class: nginx::param
#
# This module manages NGINX paramaters
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
class nginx::params {

  $defaults = {
    temp_dir                => '/tmp',
    run_dir                 => '/var/nginx',
    conf_dir                => '/etc/nginx',
    confd_purge             => false,
    worker_processes        => 1,
    worker_connections      => 1024,
    types_hash_max_size     => 1024,
    types_hash_bucket_size  => 512,
    names_hash_bucket_size  => 64,
    multi_accept            => off,
    events_use              => false, # One of [kqueue|rtsig|epoll|/dev/poll|select|poll|eventport] or false to use OS default
    sendfile                => on,
    keepalive_timeout       => 65,
    tcp_nodelay             => on,
    tcp_nopush              => on,

    gzip                    => on,
    gzip_disable            => 'MSIE [1-6]\.(?!.*SV1)',
    gzip_comp_level         => 5,
    gzip_min_length         => 100,
    gzip_vary               => off,
    gzip_types              => "text/plain text/html application/x-javascript text/css application/json",

    server_tokens           => on,
    spdy                    => off,
    ssl_stapling            => off,
    proxy_redirect          => off,

    proxy_set_header        => [
      'Host $host',
      'X-Real-IP $remote_addr',
      'X-Forwarded-For $proxy_add_x_forwarded_for',
    ],

    proxy_cache_path        => false,
    proxy_cache_levels      => 1,
    proxy_cache_keys_zone   => 'd2:100m',
    proxy_cache_max_size    => '500m',
    proxy_cache_inactive    => '20m',

    client_body_temp_path   => "${run_dir}/client_body_temp",
    client_body_buffer_size => '128k',
    client_max_body_size    => '10m',
    proxy_temp_path         => "${run_dir}/proxy_temp",
    proxy_connect_timeout   => '90',
    proxy_send_timeout      => '90',
    proxy_read_timeout      => '90',
    proxy_buffers           => '32 4,k',
    proxy_http_version      => '1.0',

    logdir => $::kernel ? {
      /(?i-mx:linux)/ => '/var/log/nginx',
    },

    pid => $::kernel ? {
      /(?i-mx:linux)/  => '/var/run/nginx.pid',
    },

    daemon_user => $::operatingsystem ? {
      /(?i-mx:debian|ubuntu)/                                                    => 'www-data',
      /(?i-mx:fedora|rhel|redhat|centos|scientific|suse|opensuse|amazon|gentoo)/ => 'nginx',
    },

    # Service restart after Nginx 0.7.53 could also be just "/path/to/nginx/bin -s HUP"
    # Some init scripts do a configtest, some don't. If configtest_enable it's true
    # then service restart will take $service_restart value, forcing configtest.
    configtest_enable => false,
    service_restart => '/etc/init.d/nginx configtest && /etc/init.d/nginx restart',

    mail => false,
  }
}
