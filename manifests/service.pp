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
class nginx::service {

  assert_private()

  if $nginx::service_manage {
    case $facts['os']['name'] {
      'OpenBSD': {
        service { $nginx::service_name:
          ensure     => $nginx::service_ensure,
          enable     => $nginx::service_enable,
          flags      => $nginx::service_flags,
          hasstatus  => true,
          hasrestart => true,
        }
      }
      default: {
        service { $nginx::service_name:
          ensure     => $nginx::service_ensure,
          enable     => $nginx::service_enable,
          hasstatus  => true,
          hasrestart => true,
        }
      }
    }
  }

  # Allow overriding of 'restart' of Service resource; not used by default
  if $nginx::service_restart {
    Service[$nginx::service_name] {
      restart => $nginx::service_restart,
    }
  }
}
