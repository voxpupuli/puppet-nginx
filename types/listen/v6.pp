# Listen on IPv6 statement
type Nginx::Listen::V6 = Variant[Array[Stdlib::IP::Address::V6::Nosubnet], Stdlib::IP::Address::V6::Nosubnet]
