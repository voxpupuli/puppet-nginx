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
  $configtest_enable = $nginx::params::nx_configtest_enable,
  $service_restart   = $nginx::params::nx_service_restart
) {
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  if $configtest_enable == true {
    Service['nginx'] {
      restart => $service_restart,
    }
  }
}
