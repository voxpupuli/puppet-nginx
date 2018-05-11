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

  $package_name             = $nginx::package_name
  $package_source           = $nginx::package_source
  $package_ensure           = $nginx::package_ensure
  $package_flavor           = $nginx::package_flavor
  $passenger_package_ensure = $nginx::passenger_package_ensure
  $manage_repo              = $nginx::manage_repo
  $purge_passenger_repo     = $nginx::purge_passenger_repo

  #Install the CentOS-specific packages on that OS, otherwise assume it's a RHEL
  #clone and provide the Red Hat-specific package. This comes into play when not
  #on RHEL or CentOS and $manage_repo is set manually to 'true'.
  $_os = $facts['os']['name'] ? {
    'centos' => 'centos',
    default  => 'rhel'
  }

  if $manage_repo {
    case $package_source {
      'nginx', 'nginx-stable': {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/${_os}/${facts['os']['release']['major']}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package['nginx'],
        }

        if $purge_passenger_repo {
          yumrepo { 'passenger':
            ensure => absent,
            before => Package['nginx'],
          }
        }
      }
      'nginx-mainline': {
        yumrepo { 'nginx-release':
          baseurl  => "http://nginx.org/packages/mainline/${_os}/${facts['os']['release']['major']}/\$basearch/",
          descr    => 'nginx repo',
          enabled  => '1',
          gpgcheck => '1',
          priority => '1',
          gpgkey   => 'http://nginx.org/keys/nginx_signing.key',
          before   => Package['nginx'],
        }

        if $purge_passenger_repo {
          yumrepo { 'passenger':
            ensure => absent,
            before => Package['nginx'],
          }
        }
      }
      'passenger': {
        if ($facts['os']['name'] in ['RedHat', 'CentOS']) and ($facts['os']['release']['major'] in ['6', '7']) {
          yumrepo { 'passenger':
            baseurl       => "https://oss-binaries.phusionpassenger.com/yum/passenger/el/${facts['os']['release']['major']}/\$basearch",
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
          fail("${facts['os']['name']} version ${facts['os']['release']['major']} is unsupported with \$package_source 'passenger'")
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
