# Class: nginx::service
#
# This module manages NGINX service management and vhost rebuild
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
class nginx::service {
  exec { 'rebuild-nginx-vhosts':
    command     => "/bin/cat ${nginx::params::nx_temp_dir}/nginx.d/* > ${nginx::params::nx_conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    subscribe   => File["${nginx::params::nx_temp_dir}/nginx.d"],
  }
  service { "nginx":
    ensure     => running,
    enable	   => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
