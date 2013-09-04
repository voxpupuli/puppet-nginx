# Class: nginx::package::redhat
#
# This module manages NGINX package installation on RedHat based systems
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
class nginx::package::redhat {
  $redhat_packages = ['nginx', 'gd', 'libXpm', 'libxslt']

  case $::operatingsystem {
    'fedora': {
      # nginx.org does not supply RPMs for fedora
      # fedora 18 provides 1.2.x packages
      # fedora 19 has 1.4.x packages are in

      # fedora 18 users will need to supply their own nginx 1.4 rpms and/or repo
      if $::lsbmajdistrelease < 19 {
        notice("${::operatingsystem} ${::lsbmajdistrelease} does not supply nginx >= 1.4 packages")
      }
    }
    default: {
      case $::lsbmajdistrelease {
        5, 6: {
          $os_rel = $::lsbmajdistrelease
        }
        default: {
          # Amazon uses the year as the $::lsbmajdistrelease
          $os_rel = 6
        }
      }

      # as of 2013-07-28
      # http://nginx.org/packages/centos appears to be identical to
      # http://nginx.org/packages/rhel
      # no other dedicated dirs exist for platforms under $::osfamily == redhat
      yumrepo { 'nginx-release':
        baseurl  => "http://nginx.org/packages/rhel/${os_rel}/\$basearch/",
        descr    => 'nginx repo',
        enabled  => '1',
        gpgcheck => '1',
        priority => '1',
        gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
      }

      Yumrepo['nginx-release'] -> Package[$redhat_packages]
    }
  }

  #Define file for nginx-repo so puppet doesn't delete it
  file { '/etc/yum.repos.d/nginx-release.repo':
    ensure  => present,
    require => Yumrepo['nginx-release'],
  }

  package { $redhat_packages:
    ensure  => $nginx::package_ensure,
  }

}
