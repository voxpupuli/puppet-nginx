# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the nginx::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#  
#  Packaged NGINX
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx {
  
  class { 'stdlib': }

  anchor{ 'nginx::begin': 
    before => Class['nginx::package'],
    notify => Class['nginx::service'],
  }
  
  class { 'nginx::package': 
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    require => Class['nginx::package'],
    notify  => Class['nginx::service'],
  }

  class { 'nginx::service': }

  anchor { 'nginx::end':
    require => Class['nginx::service'],
  }
}
