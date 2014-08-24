# Class: nginx::service::init
#
# This module manages NGINX service management via init.d
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
class nginx::service::init (
  $configtest_enable = true,
  $service_restart   = true,
  $service_ensure    = true,
) {

  $service_enable = $service_ensure ? {
    running => true,
    absent => false,
    stopped => false,
    'undef' => undef,
    default => true,
  }

  if $service_ensure == 'undef' {
    $service_ensure_real = undef
  } else {
    $service_ensure_real = $service_ensure
  }

  service { 'nginx':
    ensure     => $service_ensure_real,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Class['nginx::config'],
  }

  if $configtest_enable == true {
    Service['nginx'] {
      restart => $service_restart,
    }
  }
}
