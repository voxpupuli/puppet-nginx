include nginx

nginx::resource::vhost { 'test.local':
  ensure       => present,
  ipv6_enable  => 'true',
  proxy        => 'http://proxypass',
}

nginx::resource::vhost { 'test.local:8080':
  listen_port  => 8080,
  server_name  => 'test.local',
  ensure       => present,
  ipv6_enable  => 'true',
  proxy        => 'http://proxypass',
}

