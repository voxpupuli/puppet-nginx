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
  $manage_repo                 = true,
  $package_ensure              = 'present',
  $package_name                = 'nginx',
  $package_source              = 'nginx-stable',
  $passenger_package_ensure    = 'present',
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
    case $package_source {
      'nginx', 'nginx-stable': {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/${_os}/${::operatingsystemmajrelease}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package['nginx'],
        }

        yumrepo { 'passenger':
          ensure => absent,
          before => Package['nginx'],
        }

      }
      'nginx-mainline': {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/mainline/${_os}/${::operatingsystemmajrelease}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package['nginx'],
        }

        yumrepo { 'passenger':
          ensure => absent,
          before => Package['nginx'],
        }

      }
      'passenger': {
        if ($::operatingsystem in ['RedHat', 'CentOS']) and ($::operatingsystemmajrelease in ['6', '7']) {
          yumrepo { 'passenger':
            baseurl       => "https://oss-binaries.phusionpassenger.com/yum/passenger/el/${::operatingsystemmajrelease}/\$basearch",
            descr         => 'passenger repo',
            enabled       => '1',
            gpgcheck      => '0',
            repo_gpgcheck => '1',
            priority      => '1',
            gpgkey        => 'https://packagecloud.io/gpg.key',
            before        => Package['nginx'],
          }

          yumrepo { 'nginx-release':
            ensure => absent,
            before => Package['nginx'],
          }

          package { 'passenger':
            ensure  => $passenger_package_ensure,
            require => Yumrepo['passenger'],
          }

        } else {
          fail("${::operatingsystem} version ${::operatingsystemmajrelease} is unsupported with \$package_source 'passenger'")
        }
      }
      default: {
        fail("\$package_source must be 'nginx-stable', 'nginx-mainline', or 'passenger'. It was set to '${package_source}'")
      }
    }
  }

  package { 'nginx':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
