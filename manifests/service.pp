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
class nginx::service(
  $configtest_enable = false,
  $service_restart   = '/etc/init.d/nginx reload',
  $service_ensure    = 'running',
  $service_name      = 'nginx',
  $service_flags     = undef,
  $service_manage    = true,
) {

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

  if $service_manage {
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

  if $configtest_enable == true {
    Service['nginx'] {
      restart => $service_restart,
    }
  }
}
