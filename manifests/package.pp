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
class nginx::package(
  $package_name   = 'nginx',
  $package_source = 'nginx',
  $package_ensure = 'present',
  $manage_repo    = true,
) {

  anchor { 'nginx::package::begin': }
  anchor { 'nginx::package::end': }

  case $::osfamily {
    'redhat': {
      class { '::nginx::package::redhat':
        manage_repo    => $manage_repo,
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
        manage_repo    => $manage_repo,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    'suse': {
      class { '::nginx::package::suse':
        package_name => $package_name,
        require      => Anchor['nginx::package::begin'],
        before       => Anchor['nginx::package::end'],
      }
    }
    'archlinux': {
      class { '::nginx::package::archlinux':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    'Solaris': {
      class { '::nginx::package::solaris':
        package_name   => $package_name,
        package_source => $package_source,
        package_ensure => $package_ensure,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    'FreeBSD': {
      class { '::nginx::package::freebsd':
        package_name   => $package_name,
        package_ensure => $package_ensure,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    'Gentoo': {
      class { '::nginx::package::gentoo':
        package_name   => $package_name,
        package_ensure => $package_ensure,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    'OpenBSD': {
      class { '::nginx::package::openbsd':
        package_name   => $package_name,
        package_ensure => $package_ensure,
        require        => Anchor['nginx::package::begin'],
        before         => Anchor['nginx::package::end'],
      }
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
      }
    }
  }
}
