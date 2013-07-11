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
class nginx::package::debian (
  $nx_debian_repository     = $nginx::params::nx_debian_repository,
  ) inherits nginx::params {
  $operatingsystem_lowercase = inline_template('<%= operatingsystem.downcase %>')

  
  $package = $nx_debian_repository ? {
       /(?i-mx:dotdeb)/        => 'nginx-full',
       /(?i-mx:debian)/        => $::lsbdistcodename ? {
                                  /sarge|etch|squeeze|karmic|lucid|jaunty/    	=> 'nginx',
                                  /wheezy|jessie|precise|quantal|raring|saucy/  => 'nginx-full',
                                  },
       /(?i-mx:nginx)/                => 'nginx',
  }

  package { $package:
    ensure  => present,
    require => Anchor['nginx::apt_repo'],
  }

  anchor { 'nginx::apt_repo' : }
  case $nx_debian_repository {
      'nginx':          { $content  = "deb http://nginx.org/packages/${operatingsystem_lowercase}/ ${::lsbdistcodename} nginx
deb-src http://nginx.org/packages/${operatingsystem_lowercase}/ ${::lsbdistcodename} nginx"
                 $keyurl   = 'http://nginx.org/keys/nginx_signing.key'
                 $keyname  = 'nginx' 
                          }
      'dotdeb': { $content  = "deb http://packages.dotdeb.org ${::lsbdistcodename} all
deb-src http://packages.dotdeb.org ${::lsbdistcodename} all"
                 $keyurl   = 'http://www.dotdeb.org/dotdeb.gpg'
                 $keyname  = 'dotdeb'
                          }
      default:            { }
  }
  case $nx_debian_repository {
      'nginx','dotdeb':   { file { '/etc/apt/sources.list.d/nginx.list':
                                  ensure  => present,
                                  content => $content,
                                  mode    => '0444',
                                  require => Exec['add_nginx_apt_key'],
                                  before  => Anchor['nginx::apt_repo'],
                                  } 
                            exec { 'add_nginx_apt_key':
                                    command   => "/usr/bin/wget ${keyurl} -O - | /usr/bin/apt-key add -",
                                    unless    => "/usr/bin/apt-key list | /bin/grep -q ${keyname}",
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
      default:            { }
  }
  
}
