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
class nginx::package::redhat (
  $manage_repo    = true,
  $package_ensure = 'present',
  $package_name   = 'nginx',
) {

  #Install the CentOS-specific packages on that OS, otherwise assume it's a RHEL
  #clone and provide the Red Hat-specific package. This comes into play when not
  #on RHEL or CentOS and $manage_repo is set manually to 'true'.
  if $::operatingsystem == 'centos' {
    $_os = 'centos'
  } else {
    $_os = 'rhel'
  }

      if $manage_repo {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/${_os}/${::operatingsystemmajrelease}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package[$package_name],
        }

        file { '/etc/yum.repos.d/nginx-release.repo':
          ensure  => present,
          require => Yumrepo['nginx-release'],
        }
      }

  package { 'nginx':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
