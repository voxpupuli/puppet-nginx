# Class: nginx::package
#
# This module manages NGINX package installation
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
class nginx::package {

  $package_name             = $nginx::package_name
  $package_source           = $nginx::package_source
  $package_ensure           = $nginx::package_ensure
  $package_flavor           = $nginx::package_flavor
  $passenger_package_ensure = $nginx::passenger_package_ensure
  $manage_repo              = $nginx::manage_repo

  assert_private()

  case $facts['os']['family'] {
    'redhat': {
      contain nginx::package::redhat
    }
    'debian': {
      contain nginx::package::debian
    }
    'Solaris': {
      # $package_name needs to be specified. SFEnginx,CSWnginx depending on
      # where you get it.
      if $package_name == undef {
        fail('You must supply a value for $package_name on Solaris')
      }

      package { 'nginx':
        ensure => $package_ensure,
        name   => $package_name,
        source => $package_source,
      }
    }
    'OpenBSD': {
      package { $package_name:
        ensure => $package_ensure,
        flavor => $package_flavor,
      }
    }
    default: {
      package { $package_name:
        ensure => $package_ensure,
      }
    }
  }
}
