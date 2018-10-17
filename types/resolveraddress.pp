type Nginx::ResolverAddress = Variant[
  Stdlib::Fqdn,
  Stdlib::IP::Address::V4::Nosubnet, # TODO: add validation/templating support for IPv6
]
