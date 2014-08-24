# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters
# are managed via the nginx::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#  puppetlabs-concat - https://github.com/puppetlabs/puppetlabs-concat
#  ripinear-module_data - https://github.com/ripienaar/puppet-module-data/
#
# Sample Usage:
#
# node default {
#   include nginx
# }
class nginx(
  $package_class = "nginx::package::$::osfamily",
  $service_class = "nginx::service::init",
) (
  if $package_class != undef {
    class { $package_class: 
      before => Class['nginx::config'],
    }
  }

  if $service_class != undef {
    class { $service_class:
      subscribe => Class['nginx::config'],
    }
  }
}
