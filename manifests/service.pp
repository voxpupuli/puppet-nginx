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
class nginx::service($options) {

  $conf_dir = $options['conf_dir']
  $temp_dir = $options['temp_dir']

  exec { 'rebuild-nginx-vhosts':
    command     => "/bin/cat ${temp_dir}/nginx.d/* > ${conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${temp_dir}/nginx.d/*",
    subscribe   => File["${temp_dir}/nginx.d"],
  }
  exec { 'rebuild-nginx-mailhosts':
    command     => "/bin/cat ${temp_dir}/nginx.mail.d/* > ${conf_dir}/conf.mail.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${temp_dir}/nginx.mail.d/*",
    subscribe   => File["${temp_dir}/nginx.mail.d"],
  }
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-nginx-vhosts', 'rebuild-nginx-mailhosts'],
  }
  if $options['configtest_enable'] == true {
    Service['nginx'] {
      restart => $options['service_restart'],
    }
  }
}
