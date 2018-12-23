type Nginx::ResolverAddress = Variant[
  Stdlib::Fqdn,
  Stdlib::IP::Address::Nosubnet,
]
