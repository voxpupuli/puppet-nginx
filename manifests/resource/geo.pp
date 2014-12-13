# define: nginx::resource::geo
#
# This is a legacy resource that will be deprecated in v1.0.0
#
# Please add any additions to nginx::geo
define nginx::resource::geo (
  $networks        = undef,
  $default         = undef,
  $ensure          = undef,
  $ranges          = undef,
  $address         = undef,
  $delete          = undef,
  $proxies         = undef,
  $proxy_recursive = undef
) {
  nginx::notice::resources { $name: }

  nginx::geo { $name:
    networks        => $networks,
    default         => $default,
    ensure          => $ensure,
    ranges          => $ranges,
    address         => $address,
    delete          => $delete,
    proxies         => $proxies,
    proxy_recursive => $proxy_recursive,
  }
}
