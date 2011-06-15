# Class: nginx::params
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
  $nx_temp_dir = '/tmp'
  $nx_run_dir  = '/var/nginx'

  $nx_conf_dir           = '/etc/nginx'
  $nx_worker_processes   = 1
  $nx_worker_connections = 1024
  $nx_multi_accept       = off
  $nx_sendfile           = on
  $nx_keepalive_timeout  = 65
  $nx_tcp_nodelay        = on
  $nx_gzip               = on

  $nx_proxy_redirect          = off
  $nx_proxy_set_header        = [
    'Host $host', 'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
  ]

  $nx_client_body_temp_path   = "${nx_run_dir}/client_body_temp"
  $nx_client_body_buffer_size = '128k'
  $nx_client_max_body_size    = '10m'
  $nx_proxy_temp_path         = "${nx_run_dir}/proxy_temp"
  $nx_proxy_connect_timeout   = '90'
  $nx_proxy_send_timeout      = '90'
  $nx_proxy_read_timeout      = '90'
  $nx_proxy_buffers           = '32 4k'

  $nx_logdir = $kernel ? {
    /(?i-mx:linux)/ => '/var/log/nginx',
  }

  $nx_pid = $kernel ? {
    /(?i-mx:linux)/  => '/var/run/nginx.pid',
  }

  $nx_daemon_user = $operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                    => 'www-data',
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'nginx',
  }
}
