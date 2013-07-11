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
  anchor { 'nginx::package::begin': }
  anchor { 'nginx::package::end': }

  case $::operatingsystem {
    centos,fedora,rhel,redhat,scientific: {
      class { 'nginx::package::redhat':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    amazon,gentoo: {
      class { 'nginx::package::amazon':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'nginx::package::debian':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    opensuse,suse: {
      class { 'nginx::package::suse':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
