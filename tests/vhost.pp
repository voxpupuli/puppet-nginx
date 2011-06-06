include nginix

nginx::resource::vhost { 'test.local':
  ensure       => present,
  ipv6_enable  => 'true',
  proxy        => 'http://proxypass',
}

