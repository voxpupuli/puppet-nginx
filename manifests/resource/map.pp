# define: nginx::resource::map
#
# Legacy defined type. Will be removed soon.
define nginx::resource::map (
  $string,
  $mappings,
  $default    = undef,
  $ensure     = 'present',
  $hostnames  = false
) {

  notify { '**WARNING**: Usage of the nginx::resource::map defined type will be deprecated soon. Please use nginx::map.': }

  nginx::map { $name:
    string     => $string,
    mappings   => $mappings,
    default    => $default,
    ensure     => $ensure,
    hostnames  => $hostnames,
  }
}
