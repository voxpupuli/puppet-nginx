# Class: nginx::service
#
# This module manages NGINX service management and vhost rebuild
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

  $service_restart = $::nginx::service_restart
  $service_ensure  = $::nginx::service_ensure
  $service_name    = $::nginx::service_name
  $service_flags   = $::nginx::service_flags
  $manage_service  = $::nginx::manage_service

  $service_enable = $service_ensure ? {
    'running' => true,
    'absent'  => false,
    'stopped' => false,
    'undef'   => undef,
    default   => true,
  }

  if $service_ensure == 'undef' {
    $service_ensure_real = undef
  } else {
    $service_ensure_real = $service_ensure
  }

  if $manage_service {
    case $::osfamily {
      'OpenBSD': {
        service { 'nginx':
          ensure     => $service_ensure_real,
          name       => $service_name,
          enable     => $service_enable,
          flags      => $service_flags,
          hasstatus  => true,
          hasrestart => true,
        }
      }
      default: {
        service { 'nginx':
          ensure     => $service_ensure_real,
          name       => $service_name,
          enable     => $service_enable,
          hasstatus  => true,
          hasrestart => true,
        }
      }
    }
  }

  # Allow overriding of 'restart' of Service resource; not used by default
  if $service_restart {
    Service['nginx'] {
      restart => $service_restart,
    }
  }
}
