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
  $distro = downcase($::operatingsystem)

  package { 'nginx':
    ensure  => $nginx::package_ensure,
    require => Anchor['nginx::apt_repo'],
  }

  anchor { 'nginx::apt_repo' : }

  include '::apt'

  apt::source { 'nginx':
    location   => "http://nginx.org/packages/${distro}",
    repos      => 'nginx',
    key        => '7BD9BF62',
    key_source => 'http://nginx.org/keys/nginx_signing.key',
  }

  exec { 'apt_get_update_for_nginx':
    command     => '/usr/bin/apt-get update',
    timeout     => 240,
    returns     => [ 0, 100 ],
    refreshonly => true,
    subscribe   => Apt::Source['nginx'],
    before      => Anchor['nginx::apt_repo'],
  }
}
