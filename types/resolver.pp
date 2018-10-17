type Nginx::Resolver = Struct[{
  'addresses' => Array[Variant[Nginx::ResolverAddress,Tuple[Nginx::ResolverAddress, Stdlib::Port]]],
  'ipv6'      => Optional[Enum['on', 'off']],
  'valid'     => Optional[Nginx::Time],
}]
