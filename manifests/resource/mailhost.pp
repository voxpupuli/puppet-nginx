# define: nginx::resource::mailhost
#
# Legacy defined type. Will be removed soon.
define nginx::resource::mailhost (
  $listen_port,
  $ensure              = 'present',
  $listen_ip           = '*',
  $listen_options      = undef,
  $ipv6_enable         = false,
  $ipv6_listen_ip      = '::',
  $ipv6_listen_port    = '80',
  $ipv6_listen_options = 'default ipv6only=on',
  $ssl                 = false,
  $ssl_cert            = undef,
  $ssl_key             = undef,
  $ssl_port            = undef,
  $starttls            = 'off',
  $protocol            = undef,
  $auth_http           = undef,
  $xclient             = 'on',
  $server_name         = [$name]
) {

  notify { '**WARNING**: Usage of the nginx::resource::mailhost defined type will be deprecated soon. Please use nginx::mailhost.': }

  nginx::mailhost { $name:
    ensure              => $ensure,
    listen_port         => $listen_port,
    listen_ip           => $listen_ip,
    listen_options      => $listen_options,
    ipv6_enable         => $ipv6_enable,
    ipv6_listen_ip      => $ipv6_listen_ip,
    ipv6_listen_port    => $ipv6_listen_port,
    ipv6_listen_options => $ipv6_listen_options,
    ssl                 => $ssl,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    ssl_port            => $ssl_port,
    starttls            => $starttls,
    protocol            => $protocol,
    auth_http           => $auth_http,
    xclient             => $xclient,
    server_name         => $server_name,
  }
}
