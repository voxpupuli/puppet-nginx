# == Class: nginx::tombstone
#
#  The final resting spot for old files
#
#  Any files that need to be cleaned up as part of module evolution
#  should be placed here as to not pollute manifests
#
# === Parameters
#
#  Module takes no parameters
#
# === Variables
#
#
# === Examples
#
#  include nginx::tombstone
#
class nginx::tombstone {
  $_conf_dir = $nginx::config::conf_dir
  $_temp_dir = $nginx::config::temp_dir

  file { "${_conf_dir}/conf.d/vhost_autogen.conf":
    ensure => absent,
  }

  file { "${_conf_dir}/conf.mail.d/vhost_autogen.conf":
    ensure => absent,
  }

  file { "${_conf_dir}/sites-enabled/default":
    ensure => absent,
  }

  file { "${_conf_dir}/conf.d/default.conf":
    ensure => absent,
  }

  file { "${_conf_dir}/conf.d/example_ssl.conf":
    ensure => absent,
  }

  file { "${_temp_dir}/nginx.d":
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { "${_temp_dir}/nginx.mail.d":
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }
}
