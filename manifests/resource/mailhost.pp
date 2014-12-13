# define: nginx::resource::mailhost
#
# This is a legacy resource that will be deprecated in v1.0.0
#
# Please add any additions to nginx::mailhost
define nginx::resource::mailhost (
  $listen_port         = undef,
  $ensure              = undef,
  $listen_ip           = undef,
  $listen_options      = undef,
  $ipv6_enable         = undef,
  $ipv6_listen_ip      = undef,
  $ipv6_listen_port    = undef,
  $ipv6_listen_options = undef,
  $ssl                 = undef,
  $ssl_cert            = undef,
  $ssl_key             = undef,
  $ssl_port            = undef,
  $starttls            = undef,
  $protocol            = undef,
  $auth_http           = undef,
  $xclient             = undef,
  $server_name         = undef,
) {
  nginx::notice::resources { $name: }

  nginx::mailhost { $name:
    listen_port         = $listen_port,
    ensure              = $ensure,
    listen_ip           = $listen_ip,
    listen_options      = $listen_options,
    ipv6_enable         = $ipv6_enable,
    ipv6_listen_ip      = $ipv6_listen_ip,
    ipv6_listen_port    = $ipv6_listen_port,
    ipv6_listen_options = $ipv6_listen_options,
    ssl                 = $ssl,
    ssl_cert            = $ssl_cert,
    ssl_key             = $ssl_key,
    ssl_port            = $ssl_port,
    starttls            = $starttls,
    protocol            = $protocol,
    auth_http           = $auth_http,
    xclient             = $xclient,
    server_name         = $server_name,
  }
}
