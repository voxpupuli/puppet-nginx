# Class: nginx::package::debian
#
# This module manages NGINX package installation on debian based systems
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
class nginx::package::debian {

  $package_name             = $nginx::package_name
  $package_source           = $nginx::package_source
  $package_ensure           = $nginx::package_ensure
  $package_flavor           = $nginx::package_flavor
  $passenger_package_ensure = $nginx::passenger_package_ensure
  $manage_repo              = $nginx::manage_repo
  $release                  = $nginx::repo_release
  $repo_source              = $nginx::repo_source

  $distro = downcase($facts['os']['name'])

  package { 'nginx':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $manage_repo {
    include 'apt'
    Exec['apt_update'] -> Package['nginx']

    case $package_source {
      'nginx', 'nginx-stable': {
        $stable_repo_source = $repo_source ? {
          undef => "https://nginx.org/packages/${distro}",
          default => $repo_source,
        }
        apt::source { 'nginx':
          location => $stable_repo_source,
          repos    => 'nginx',
          key      => {'id' => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62'},
          release  => $release,
        }
      }
      'nginx-mainline': {
        $mainline_repo_source = $repo_source ? {
          undef => "https://nginx.org/packages/mainline/${distro}",
          default => $repo_source,
        }
        apt::source { 'nginx':
          location => $mainline_repo_source,
          repos    => 'nginx',
          key      => {'id' => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62'},
          release  => $release,
        }
      }
      'passenger': {
        $passenger_repo_source = $repo_source ? {
          undef => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
          default => $repo_source,
        }
        apt::source { 'nginx':
          location => $passenger_repo_source,
          repos    => 'main',
          key      => {'id' => '16378A33A6EF16762922526E561F9B9CAC40B2F7'},
        }

        package { 'passenger':
          ensure  => $passenger_package_ensure,
          require => Exec['apt_update'],
        }

        if $package_name != 'nginx-extras' {
          warning('You must set $package_name to "nginx-extras" to enable Passenger')
        }
      }
      default: {
        fail("\$package_source must be 'nginx-stable', 'nginx-mainline' or 'passenger'. It was set to '${package_source}'")
      }
    }
  }
}
