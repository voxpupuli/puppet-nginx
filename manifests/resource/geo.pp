# define: nginx::resource::geo
#
# This definition creates a new geo mapping entry for NGINX
#
# Parameters:
#   [*networks*]        - Hash of geo lookup keys and resultant values
#   [*default*]         - Sets the resulting value if the source value fails to
#                         match any of the variants.
#   [*ensure*]          - Enables or disables the specified location
#   [*ranges*]          - Indicates that lookup keys (network addresses) are
#                         specified as ranges.
#   [*address*]         - Nginx defaults to using $remote_addr for testing.
#                         This allows you to override that with another variable
#                         name (automatically prefixed with $)
#   [*delete*]          - deletes the specified network (see: geo module docs)
#   [*proxy_recursive*] - Changes the behavior of address acquisition when
#                         specifying trusted proxies via 'proxies' directive
#   [*proxies*]         - Hash of network->value mappings.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#  nginx::resource::geo { 'client_network':
#    ensure          => present,
#    ranges          => false,
#    default         => extra,
#    proxy_recursive => false,
#    proxies         => [ '192.168.99.99' ],
#    networks        => {
#      '10.0.0.0/8'     => 'intra',
#      '172.16.0.0/12'  => 'intra',
#      '192.168.0.0/16' => 'intra',
#    }
#  }
#
# Sample Hiera usage:
#
#  nginx::geo_mappings:
#    client_network:
#      ensure: present
#      ranges: false
#      default: 'extra'
#      proxy_recursive: false
#      proxies:
#         - 192.168.99.99
#      networks:
#        '10.0.0.0/8': 'intra'
#        '172.16.0.0/12': 'intra'
#        '192.168.0.0/16': 'intra'


define nginx::resource::geo (
  Hash $networks,
  Optional[String] $default           = undef,
  Enum['present', 'absent'] $ensure   = 'present',
  Boolean $ranges                     = false,
  Optional[String] $address           = undef,
  Optional[String] $delete            = undef,
  Optional[Array] $proxies            = undef,
  Optional[Boolean] $proxy_recursive  = undef
) {

  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  $root_group = $nginx::root_group
  $conf_dir   = "${nginx::conf_dir}/conf.d"

  $ensure_real = $ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  File {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  file { "${conf_dir}/${name}-geo.conf":
    ensure  => $ensure_real,
    content => template('nginx/conf.d/geo.erb'),
    notify  => Class['nginx::service'],
    require => File[$conf_dir],
  }
}
