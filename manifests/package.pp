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

  assert_private()

  $package_name   = $::nginx::package_name
  $package_source = $::nginx::package_source
  $package_ensure = $::nginx::package_ensure
  $package_flavor = $::nginx::package_flavor

  anchor { 'nginx::package::begin': }
  anchor { 'nginx::package::end': }

  case $::osfamily {
    'redhat': {
      class { '::nginx::package::redhat':
        package_source => $package_source,
        package_ensure => $package_ensure,
        package_name   => $package_name,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    'debian': {
      class { '::nginx::package::debian':
        package_name   => $package_name,
        package_source => $package_source,
        package_ensure => $package_ensure,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
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
