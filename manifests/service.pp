# @summary Manage NGINX service management
# @api private
class nginx::service {
  assert_private()

  if $nginx::service_manage {
    service { $nginx::service_name:
      ensure  => $nginx::service_ensure,
      enable  => $nginx::service_enable,
      flags   => $nginx::service_flags,
      restart => $nginx::service_restart,
    }
  }
}
