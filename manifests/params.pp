# Class: nginx::param
#
# This module manages NGINX paramaters
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
class nginx::params {

  $pid = $::kernel ? {
    /(?i-mx:linux)/   => $::osfamily ? {
        # archlinux has hardcoded pid in service file to /run/nginx.pid, setting
        # it will prevent nginx from starting
        /(?i-mx:archlinux)/ => false,
        default             => '/var/run/nginx.pid',
    },
    /(?i-mx:sunos)/   => '/var/run/nginx.pid',
    /(?i-mx:freebsd)/ => '/var/run/nginx.pid',
  }

  $conf_dir = $::kernelversion ? {
    /(?i-mx:joyent)/    => '/opt/local/etc/nginx',
    default             => $::kernel ? {
      /(?i-mx:freebsd)/ => '/usr/local/etc/nginx',
      default           => '/etc/nginx',
    }
  }

  if $::osfamily {
    $solaris_daemon_user = $::kernelversion ? {
      /(?i-mx:joyent)/ => 'www',
      default => 'webservd',
    }
    $daemon_user = $::osfamily ? {
      /(?i-mx:archlinux)/                => 'http',
      /(?i-mx:redhat|suse|gentoo|linux)/ => 'nginx',
      /(?i-mx:debian)/                   => 'www-data',
      /(?i-mx:solaris)/                  => $solaris_daemon_user,
      /(?i-mx:freebsd)/                  => 'www',
    }
  } else {
    warning('$::osfamily not defined. Support for $::operatingsystem is deprecated')
    warning("Please upgrade from facter ${::facterversion} to >= 1.7.2")
    $daemon_user = $::operatingsystem ? {
      /(?i-mx:archlinux)/                                                                    => 'http',
      /(?i-mx:debian|ubuntu)/                                                                => 'www-data',
      /(?i-mx:fedora|rhel|redhat|centos|scientific|suse|opensuse|amazon|gentoo|oraclelinux)/ => 'nginx',
      /(?i-mx:solaris)/                                                                      => 'webservd',
      /(?i-mx:freebsd)/                                                                      => 'www',
    }
  }

  $root_group = $::operatingsystem ? {
    'FreeBSD' => 'wheel',
    default   => 'root',
  }

  $sites_available_group = $root_group
  $global_group = $root_group
}
