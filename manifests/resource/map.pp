# define: nginx::resource::map
#
# This is a legacy resource that will be deprecated in v1.0.0
#
# Please add any additions to nginx::map
define nginx::resource::map (
  $string     = undef,
  $mappings   = undef,
  $default    = undef,
  $ensure     = undef,
  $hostnames  = undef,
) {
  nginx::notice::resources { $name: }

  nginx::map { $name:
    string     => $string,
    mappings   => $mappings,
    default    => $default,
    ensure     => $ensure,
    hostnames  => $hostnames,
  }
}
