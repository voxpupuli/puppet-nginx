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
class nginx::package::debian(
    $manage_repo    = true,
    $package_name   = 'nginx',
    $package_source = 'nginx',
    $package_ensure = 'present'
  ) {

  $distro = downcase($::operatingsystem)

  package { 'nginx':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $manage_repo {
    include '::apt'
    Exec['apt_update'] -> Package['nginx']

    case $package_source {
      'nginx', 'nginx-stable': {
        apt::ppa { 'ppa:nginx/stable':
          ensure => present,
        }
      }
      'nginx-mainline': {
        apt::ppa { 'ppa:nginx/stable':
          ensure => present,
        }
      }
      'passenger': {
        apt::source { 'nginx':
          location => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
          repos    => 'main',
          key      => '16378A33A6EF16762922526E561F9B9CAC40B2F7',
        }

        ensure_packages([ 'apt-transport-https', 'ca-certificates' ])

        Package['apt-transport-https','ca-certificates'] -> Apt::Source['nginx']

        package { 'passenger':
          ensure  => 'present',
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
