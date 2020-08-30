# @summary Create a virtual steamhost
#
# @param ensure
#   Enables or disables the specified streamhost
# @param listen_ip
#   Default IP Address for NGINX to listen with this streamhost on. Defaults to
#   all interfaces (*)
# @param listen_port
#   Default TCP Port for NGINX to listen with this streamhost on.
# @param listen_options
#   Extra options for listen directive like 'default' to catchall.
# @param ipv6_enable
#   Value to enable/disable IPv6 support Module will check to see if IPv6
#   support exists on your system before enabling.
# @param ipv6_listen_ip
#   Default IPv6 Address for NGINX to listen with this streamhost on. Defaults
#   to all interfaces (::)
# @param ipv6_listen_port
#   Default IPv6 Port for NGINX to listen with this streamhost on.
# @param ipv6_listen_options
#   Extra options for listen directive like 'default' to catchall. Template
#   will allways add ipv6only=on. While issue jfryman/puppet-nginx#30 is
#   discussed, default value is 'default'.
# @param proxy
#   Proxy server(s) for the root location to connect to. Accepts a single
#   value, can be used in conjunction with nginx::resource::upstream
# @param proxy_read_timeout
#   Override the default the proxy read timeout value of 90 seconds
# @param resolver
#   Configures name servers used to resolve names of upstream servers into
#   addresses.
# @param raw_prepend
#   A single string, or an array of strings to prepend to the server directive
#   (after cfg prepend directives). NOTE: YOU are responsible for a semicolon
#   on each line that requires one.
# @param raw_append
#   A single string, or an array of strings to append to the server directive
#   (after cfg append directives). NOTE: YOU are responsible for a semicolon on
#   each line that requires one.
# @param owner
#   Defines owner of the .conf file
# @param group
#   Defines group of the .conf file
# @param mode
#   Defines mode of the .conf file Default to return 503
#
# @example
#   nginx::resource::streamhost { 'test2.local':
#     ensure   => present,
#   }
#
define nginx::resource::streamhost (
  Enum['absent', 'present'] $ensure            = 'present',
  Variant[Array, String] $listen_ip            = '*',
  Integer $listen_port                         = 80,
  Optional[String] $listen_options             = undef,
  Boolean $ipv6_enable                         = false,
  Variant[Array, String] $ipv6_listen_ip       = '::',
  Integer $ipv6_listen_port                    = 80,
  String $ipv6_listen_options                  = 'default ipv6only=on',
  $proxy                                       = undef,
  String $proxy_read_timeout                   = $nginx::proxy_read_timeout,
  $proxy_connect_timeout                       = $nginx::proxy_connect_timeout,
  Array $resolver                              = [],
  Variant[Array[String], String] $raw_prepend  = [],
  Variant[Array[String], String] $raw_append   = [],
  String $owner                                = $nginx::global_owner,
  String $group                                = $nginx::global_group,
  String $mode                                 = $nginx::global_mode,
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  # Variables
  if $nginx::confd_only {
    $streamhost_dir = "${nginx::conf_dir}/conf.stream.d"
  } else {
    $streamhost_dir = "${nginx::conf_dir}/streams-available"
    $streamhost_enable_dir = "${nginx::conf_dir}/streams-enabled"
    $streamhost_symlink_ensure = $ensure ? {
      'absent' => absent,
      default  => 'link',
    }
  }

  $name_sanitized = regsubst($name, ' ', '_', 'G')
  $config_file = "${streamhost_dir}/${name_sanitized}.conf"

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if $ipv6_enable and !$facts['networking']['ip6'] {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  concat { $config_file:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    notify  => Class['nginx::service'],
    require => File[$streamhost_dir],
    tag     => 'nginx_config_file',
  }

  concat::fragment { "${name_sanitized}-header":
    target  => $config_file,
    content => template('nginx/streamhost/streamhost.erb'),
    order   => '001',
  }

  unless $nginx::confd_only {
    file { "${name_sanitized}.conf symlink":
      ensure  => $streamhost_symlink_ensure,
      path    => "${streamhost_enable_dir}/${name_sanitized}.conf",
      target  => $config_file,
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      require => Concat[$config_file],
      notify  => Class['nginx::service'],
    }
  }
}
