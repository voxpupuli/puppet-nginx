# define: nginx::resource::geo
#
# Legacy defined type. Will be removed soon.
define nginx::resource::geo (
  $networks,
  $default         = undef,
  $ensure          = 'present',
  $ranges          = false,
  $address         = undef,
  $delete          = undef,
  $proxies         = undef,
  $proxy_recursive = undef
) {

  notify { '**WARNING**: Usage of the nginx::resource::geo defined type will be deprecated soon. Please use nginx::geo.': }

  nginx::geo { $name:
    ensure          => $ensure,
    networks        => $networks,
    default         => $default,
    ranges          => $ranges,
    address         => $address,
    delete          => $delete,
    proxies         => $proxies,
    proxy_recursive => $proxy_recursive,
  }
}
