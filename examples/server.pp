include nginx

nginx::resource::server { 'test.local test':
  ensure      => present,
  ipv6_enable => true,
  proxy       => 'http://proxypass',
}

nginx::resource::server { 'test.local:8080':
  ensure      => present,
  listen_port => 8080,
  server_name => ['test.local test'],
  ipv6_enable => true,
  proxy       => 'http://proxypass',
}

