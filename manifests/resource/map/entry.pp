# define: nginx::resource::map::entry
#
# This definition creates a new mapping entry key => value pair for NGINX. It is used in cases when
# $mappings variable is not defined. If a resource nginx::resource::map with no $mappings is defined,
# Puppet would expect nginx::resource::map::entry definitions to construct the map from different places.
#
#   [*map*]        - A title of the corresponding nginx::resource::map resource.
#   [*key*]        - A key for the mapping
#   [*value*]      - A value for the mapping
#   [*order*]      - Optional order for other mapping entries. Default is the key itself.
#
# Actions:
#
# Requires:
#
# Usage:
#
#  nginx::resource::map { 'backend_pool':
#    ensure    => present,
#    hostnames => true,
#    default   => 'ny-pool-1,
#    string    => '$http_host'
#  }
#
#  nginx::resource::map::entry { 'backend_pool_nyc':
#    map => 'backend_pool',
#    key => '*.nyc.example.com',
#    value => 'ny-pool-1'
#  }
#
#  nginx::resource::map::entry { 'backend_pool_sf':
#    map => 'backend_pool',
#    key => '*.sf.example.com',
#    value => 'sf-pool-1'
#  }
#
# Usage (preserving input of order of mappings):
#
#  nginx::resource::map { 'backend_pool':
#    ensure    => present,
#    hostnames => true,
#    default   => 'ny-pool-1,
#    string    => '$http_host'
#  }
#
#  nginx::resource::map::entry { 'backend_pool_nyc':
#    map => 'backend_pool',
#    key => '*.nyc.example.com',
#    value => 'ny-pool-1',
#    order => '2'
#  }
#
#  nginx::resource::map::entry { 'backend_pool_sf':
#    map => 'backend_pool',
#    key => '*.sf.example.com',
#    value => 'sf-pool-1',
#    order => '1'
#  }
#

define nginx::resource::map::entry (
  String $map,
  String $key,
  String $value,
  String $order = $key
) {

  if ! defined(Nginx::Resource::Map[$map]) {
    fail("No such map ${map} defined")
  }

  if (getparam(Nginx::Resource::Map[$map], "mappings") != "") {
    fail("Map ${map} has \$mappings defined, cannot use entry.")
  }

  concat::fragment { "${::nginx::conf_dir}/conf.d/${map}_${key}":
    target => "${::nginx::conf_dir}/conf.d/${map}-map.conf",
    content => "  ${key} ${value};\n",
    order => "5_${order}"
  }

}
