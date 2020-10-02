# Listen on IPv4 statement
type Nginx::Listen::V4 = Variant[Enum['*'], Array[Stdlib::IP::Address::V4::Nosubnet], Stdlib::IP::Address::V4::Nosubnet]
