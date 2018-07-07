# Class: nginx::service
#
# This module manages NGINX service management and server rebuild
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
class nginx::service(
  $service_restart = $nginx::service_restart,
  $service_ensure  = $nginx::service_ensure,
  $service_enable  = $nginx::service_enable,
  $service_name    = $nginx::service_name,
  $service_flags   = $nginx::service_flags,
  $service_manage  = $nginx::service_manage,
) {

  assert_private()

  if $service_manage {
    case $facts['os']['name'] {
      'OpenBSD': {
        service { $service_name:
          ensure     => $service_ensure,
          enable     => $service_enable,
          flags      => $service_flags,
          hasstatus  => true,
          hasrestart => true,
        }
      }
      default: {
        service { $service_name:
          ensure     => $service_ensure,
          enable     => $service_enable,
          hasstatus  => true,
          hasrestart => true,
        }
      }
    }
  }

  # Allow overriding of 'restart' of Service resource; not used by default
  if $service_restart {
    Service[$service_name] {
      restart => $service_restart,
    }
  }
}
