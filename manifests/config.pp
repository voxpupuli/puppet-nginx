# Class: nginx::config
#
# This module manages NGINX bootstrap and configuration
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

class nginx::config($options) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  # some of these are accessed from other manifests/templates
  $conf_dir    = $options['conf_dir']
  $confd_purge = $options['confd_purge']
  $usr         = $options['daemon_user']
  $temp_dir    = $options['temp_dir']
  $logdir      = $options['logdir']

  file { $conf_dir:
    ensure => directory,
  }

  file { "${conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${conf_dir}/conf.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { "${conf_dir}/conf.mail.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${conf_dir}/conf.mail.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { $options['run_dir']:
    ensure => directory,
  }

  file { $options['client_body_temp_path']:
    ensure => directory,
    owner  => $usr,
  }

  file { $options['proxy_temp_path']:
    ensure => directory,
    owner  => $usr,
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
  }

  file { "${conf_dir}/nginx.conf":
    ensure  => file,
    content => template('nginx/conf.d/nginx.conf.erb'),
  }

  file { "${temp_dir}/nginx.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${temp_dir}/nginx.mail.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
}
