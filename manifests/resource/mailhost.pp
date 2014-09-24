# See README.md for usage information
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

  include nginx::params
  $root_group = $nginx::params::root_group

  File {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  if !is_integer($listen_port) {
    fail('$listen_port must be an integer.')
  }
  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  validate_string($listen_ip)
  if ($listen_options != undef) {
    validate_string($listen_options)
  }
  validate_bool($ipv6_enable)
  validate_string($ipv6_listen_ip)
  if !is_integer($ipv6_listen_port) {
    fail('$ipv6_listen_port must be an integer.')
  }
  validate_string($ipv6_listen_options)
  validate_bool($ssl)
  if ($ssl_cert != undef) {
    validate_string($ssl_cert)
  }
  if ($ssl_key != undef) {
    validate_string($ssl_key)
  }
  if ($ssl_port != undef) and (!is_integer($ssl_port)) {
    fail('$ssl_port must be an integer.')
  }
  validate_re($starttls, '^(on|only|off)$',
    "${starttls} is not supported for starttls. Allowed values are 'on', 'only' and 'off'.")
  if ($protocol != undef) {
    validate_string($protocol)
  }
  if ($auth_http != undef) {
    validate_string($auth_http)
  }
  validate_string($xclient)
  validate_array($server_name)

  $config_file = "${nginx::config::conf_dir}/conf.mail.d/${name}.conf"

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if ($ipv6_enable and !$::ipaddress6) {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl or $starttls == 'on' or $starttls == 'only') {
    if ($ssl_cert == undef) or ($ssl_key == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }

  concat { $config_file:
    owner  => 'root',
    group  => $root_group,
    mode   => '0644',
    notify => Class['nginx::service'],
  }

  if ($listen_port != $ssl_port) {
    concat::fragment { "${name}-header":
      ensure  => present,
      target  => $config_file,
      content => template('nginx/mailhost/mailhost.erb'),
      order   => '001',
    }
  }

  # Create SSL File Stubs if SSL is enabled
  if ($ssl) {
    concat::fragment { "${name}-ssl":
      ensure  => present,
      target  => $config_file,
      content => template('nginx/mailhost/mailhost_ssl.erb'),
      order   => '700',
    }
  }
}
