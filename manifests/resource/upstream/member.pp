# See README.md for usage information
define nginx::resource::upstream::member (
  $upstream,
  $server,
  $port                   = '80',
  $upstream_fail_timeout  = '10s',
) {

  # Uses: $server, $port, $upstream_fail_timeout
  concat::fragment { "${upstream}_upstream_member_${name}":
    target  => "${nginx::config::conf_dir}/conf.d/${upstream}-upstream.conf",
    order   => 40,
    content => template('nginx/conf.d/upstream_member.erb'),
  }
}
