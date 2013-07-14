# NGINX Module

James Fryman <james@frymanet.com>

This module manages NGINX from within Puppet.

# Quick Start

Install and bootstrap an NGINX instance, and add some custom config directives

```
node default {
  class { 'nginx':
    options => [
      worker_processes => '1',
      gzip_vary => on
    ]
  }
}
```

A full list of available options are available in manifests/params.pp

Setup a new virtual host

```
node default {
  class { 'nginx': }
  nginx::resource::vhost { 'www.puppetlabs.com':
    ensure   => present,
    www_root => '/var/www/www.puppetlabs.com',
  }
}
```

Add a Proxy Server(s)

```
node default {
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
    ensure   => present,
    proxy  => 'http://puppet_rack_app',
  }
}
```

Add a location (for example, to serve static files from nginx)

```
node default {
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
}
```

Add an smtp proxy

```
node default {
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
}
```
