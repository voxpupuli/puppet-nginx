# @summary Manage NGINX service management
#
# @api private
#
class nginx::service {
  assert_private()

  if $nginx::service_config_check {
    exec { 'nginx_config_check':
      command     => 'nginx -t',
      refreshonly => true,
      path        => [
        '/usr/local/sbin',
        '/usr/local/bin',
        '/usr/sbin',
        '/usr/bin',
        '/sbin',
        '/bin',
      ],
    }

    File <| tag == 'nginx_config_file' |> ~> Exec['nginx_config_check']
    Concat <| tag == 'nginx_config_file' |> ~> Exec['nginx_config_check']
  }

  if $nginx::service_manage {
    $service_require = $nginx::service_config_check ? {
      true  => Exec['nginx_config_check'],
      false => undef,
    }

    service { $nginx::service_name:
      ensure  => $nginx::service_ensure,
      enable  => $nginx::service_enable,
      flags   => $nginx::service_flags,
      restart => $nginx::service_restart,
      require => $service_require,
    }
  }
}
