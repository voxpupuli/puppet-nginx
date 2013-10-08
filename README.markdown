# NGINX Module

James Fryman <james@frymanet.com>

This module manages NGINX configuration.

## Quick Start

Install and bootstrap an NGINX instance, and add some custom config directives

```puppet
class { 'nginx':
  options => [
    worker_processes => '1',
    gzip_vary => on
  ]
}
```

A full list of available options are available in manifests/params.pp

### Setup a new virtual host

```puppet
nginx::resource::vhost { 'www.puppetlabs.com':
  ensure   => present,
  www_root => '/var/www/www.puppetlabs.com',
}
```

### Add a Proxy Server

```puppet
nginx::resource::upstream { 'puppet_rack_app':
 ensure  => present,
 members => [
   'localhost:3000',
   'localhost:3001',
   'localhost:3002',
 ],
}

nginx::resource::vhost { 'rack.puppetlabs.com':
  ensure => present,
  proxy  => 'http://puppet_rack_app',
}
```

### Add a smtp proxy

```puppet

class { 'nginx':
 mail => true,
}

nginx::resource::mailhost { 'domain1.example':
 ensure      => present,
 auth_http   => 'server2.example/cgi-bin/auth',
 protocol    => 'smtp',
 listen_port => 587,
 ssl_port    => 465,
 starttls    => 'only',
 xclient     => 'off',
 ssl         => 'true',
 ssl_cert    => '/tmp/server.crt',
 ssl_key     => '/tmp/server.pem',
}
```

### Add a location

For example, to serve static files from nginx

```
class { 'nginx': }
nginx::resource::upstream { 'puppet_rack_app':
  ensure  => present,
  members => [
    'localhost:3000',
    'localhost:3001',
    'localhost:3002',
  ],
}

nginx::resource::vhost { 'rack.puppetlabs.com':
  ensure => present,
  proxy  => 'http://puppet_rack_app',
}

nginx::resource::location { 'puppetlabs.com-static':
  ensure              => present,
  vhost               => 'rack.puppetlabs.com',
  location            => '/static',
  location_alias      => '/var/www/static',
  location_cfg_append => {
    'access_log' => 'off',
    'expires'    => '14d'
  }
}
```

## Hiera Support

Defining nginx resources in Hiera.

```yaml
nginx::nginx_upstreams:
  'puppet_rack_app':
    ensure: present
    members:
      - localhost:3000
      - localhost:3001
      - localhost:3002
nginx::nginx_vhosts:
  'www.puppetlabs.com':
    www_root: '/var/www/www.puppetlabs.com'
  'rack.puppetlabs.com':
    ensure: present
    proxy: 'http://puppet_rack_app'
nginx::nginx_locations:
  'static':
    location: '~ "^/static/[0-9a-fA-F]{8}\/(.*)$"'
    vhost: www.puppetlabs.com
  'userContent':
    location: /userContent
    vhost: www.puppetlabs.com
    www_root: /var/www/html
```

## Nginx with precompiled Passenger

Currently this works only for Debian family.

```puppet
class { 'nginx':
  package_source => 'passenger',
  http_cfg_append => {
   'passenger_root' => '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
  }
}
```

Package source `passenger` will add [Phusion Passenger repository](https://oss-binaries.phusionpassenger.com/apt/passenger) to APT sources.
For each virtual host you should specify which ruby should be used.

```puppet
vhost_cfg_append => {
  'passenger_enabled'         => 'on',
  'passenger_ruby'            => '/usr/bin/ruby'
}
```

### Puppet master served by Nginx and Passenger

Virtual host config for serving puppet master:

```puppet
nginx::resource::vhost { 'puppet':
  ensure      => present,
  server_name => ['puppet'],
  listen_port => 8140,
  ssl         => true,
  ssl_cert    => '/var/lib/puppet/ssl/certs/example.com.pem',
  ssl_key     => '/var/lib/puppet/ssl/private_keys/example.com.pem',
  ssl_port    => 8140,
  ssl_cache   => 'shared:SSL:128m',
  ssl_ciphers => 'SSLv2:-LOW:-EXPORT:RC4+RSA',
  vhost_cfg_append => {
    'passenger_enabled'         => 'on',
    'passenger_ruby'            => '/usr/bin/ruby',
    'ssl_crl'                   => '/var/lib/puppet/ssl/ca/ca_crl.pem',
    'ssl_client_certificate'    => '/var/lib/puppet/ssl/certs/ca.pem',
    'ssl_verify_client'         => 'optional',
    'ssl_verify_depth'          => 1,
  },
  www_root    => '/etc/puppet/rack/public',
  use_default_location => false,
  access_log  => '/var/log/nginx/puppet_access.log',
  error_log   => '/var/log/nginx/puppet_error.log',
  passenger_cgi_param => {
    'SSL_CLIENT_S_DN'   => '$ssl_client_s_dn',
    'SSL_CLIENT_VERIFY' => '$ssl_client_verify',
  },
}
```
