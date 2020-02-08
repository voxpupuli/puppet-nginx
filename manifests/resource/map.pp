# define: nginx::resource::map
#
# This definition creates a new mapping entry for NGINX
#
# Parameters:
#   [*ensure*]     - Enables or disables the specified location (present|absent)
#   [*default*]    - Sets the resulting value if the source values fails to
#                    match any of the variants.
#   [*string*]     - Source string or variable to provide mapping for
#   [*mappings*]   - Hash of map lookup keys and resultant values
#   [*hostnames*]  - Indicates that source values can be hostnames with a
#                    prefix or suffix mask.
#   [*include_files*]   - An array of external files to include
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#  nginx::resource::map { 'backend_pool':
#    ensure    => present,
#    hostnames => true,
#    default   => 'ny-pool-1,
#    string    => '$http_host',
#    mappings  => {
#      '*.nyc.example.com' => 'ny-pool-1',
#      '*.sf.example.com'  => 'sf-pool-1',
#    }
#  }
#
# Sample Usage (preserving input of order of mappings):
#
#  nginx::resource::map { 'backend_pool':
#    ...
#    mappings  => [
#      { 'key' => '*.sf.example.com', 'value' => 'sf-pool-1' },
#      { 'key' => '*.nyc.example.com', 'value' => 'ny-pool-1' },
#    ]
#  }
#
# Sample Usage (using external include)
#
# nginx::resource::map { 'redirections':
#
#    include_files => [ '/etc/nginx/conf.d/redirections.map']
#
# }
#
# Sample Hiera usage:
#
#  nginx::string_mappings:
#    client_network:
#      ensure: present
#      hostnames: true
#      default: 'ny-pool-1'
#      string: $http_host
#      mappings:
#        '*.nyc.example.com': 'ny-pool-1'
#        '*.sf.example.com': 'sf-pool-1'
#
# Sample Hiera usage (preserving input of order of mappings):
#
#  nginx::string_mappings:
#    client_network:
#      ...
#      mappings:
#        - key: '*.sf.example.com'
#          value: 'sf-pool-1'
#        - key: '*.nyc.example.com'
#          value: 'ny-pool-1'


define nginx::resource::map (
  String[2] $string,
  Variant[Array, Hash] $mappings,
  Optional[String] $default         = undef,
  Enum['absent', 'present'] $ensure = 'present',
  Array[String] $include_files      = [],
  Boolean $hostnames                = false
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  $root_group = $nginx::root_group
  $conf_dir   = "${nginx::conf_dir}/conf.d"

  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => 'file',
  }

  File {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  file { "${nginx::conf_dir}/conf.d/${name}-map.conf":
    ensure  => $ensure_real,
    content => template('nginx/conf.d/map.erb'),
    notify  => Class['nginx::service'],
    require => File[$conf_dir],
  }
}
