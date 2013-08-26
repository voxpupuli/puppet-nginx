# NGINX Module

James Fryman <james@frymanet.com>

This module manages NGINX configuration.

## Quick Start

### Install and bootstrap an NGINX instance

```puppet
class { 'nginx': }
```

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
