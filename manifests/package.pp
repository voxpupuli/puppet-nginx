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

  case $::osfamily {
    'redhat': {
      class { 'nginx::package::redhat':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    'debian': {
      class { 'nginx::package::debian':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    'suse': {
      class { 'nginx::package::suse':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    default: {
      case $::operatingsystem {
        'amazon': {
          # Amazon was added to osfamily RedHat in 1.7.2
          # https://github.com/puppetlabs/facter/commit/c12d3b6c557df695a7b2b009da099f6a93c7bd31#lib/facter/osfamily.rb
          warning("Module ${module_name} support for ${::operatingsystem} with facter < 1.7.2 is deprecated")
          warning("Please upgrade from facter ${::facterversion} to >= 1.7.2")
          class { 'nginx::package::redhat':
            require => Anchor['nginx::package::begin'],
            before  => Anchor['nginx::package::end'],
          }
        }
        default: {
          fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
      }
    }
  }
}
