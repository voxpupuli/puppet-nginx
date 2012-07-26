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
  case $::operatingsystem {
    centos,fedora,rhel: {
      include nginx::package::redhat
    }
    debian,ubuntu: {
      include nginx::package::debian
    }
    opensuse,suse: {
      include nginx::package::suse
    }
    default: {
      err "module nginx is not supported for operating system ${::operatingsystem}"
    }
  }
}