# Class: nginx::package::amazon
#
# This module manages NGINX package installation on ec2 amazon linux  based systems
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
class nginx::package::amazon {
  package { 'nginx':
    ensure => present,
  }
}
