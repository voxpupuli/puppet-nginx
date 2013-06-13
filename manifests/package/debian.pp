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
  $operatingsystem_lowercase = inline_template('<%= operatingsystem.downcase %>')

  package { 'nginx':
    ensure  => present,
    require => Anchor['nginx::apt_repo'],
  }

  anchor { 'nginx::apt_repo' : }

  file { '/etc/apt/sources.list.d/nginx.list':
    ensure  => present,
    content => "deb http://nginx.org/packages/${operatingsystem_lowercase}/ ${::lsbdistcodename} nginx
                deb-src http://nginx.org/packages/${operatingsystem_lowercase}/ ${::lsbdistcodename} nginx
               ",
    mode    => '0444',
    require => Exec['add_nginx_apt_key'],
    before  => Anchor['nginx::apt_repo'],
  }

  exec { 'add_nginx_apt_key':
    command   => '/usr/bin/wget http://nginx.org/keys/nginx_signing.key -O - | /usr/bin/apt-key add -',
    unless    => '/usr/bin/apt-key list | /bin/grep -q nginx',
    before    => Anchor['nginx::apt_repo'],
  }

  exec { 'apt_get_update_for_nginx':
    command     => '/usr/bin/apt-get update',
    timeout     => 240,
    returns     => [ 0, 100 ],
    refreshonly => true,
    subscribe   => File['/etc/apt/sources.list.d/nginx.list'],
    before      => Anchor['nginx::apt_repo'],
  }
}
