# NGINX module for Puppet

[![Build Status](https://travis-ci.org/voxpupuli/puppet-nginx.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-nginx)
[![Code Coverage](https://coveralls.io/repos/github/voxpupuli/puppet-nginx/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-nginx)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/nginx.svg)](https://forge.puppetlabs.com/puppet/nginx)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/nginx.svg)](https://forge.puppetlabs.com/puppet/nginx)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/nginx.svg)](https://forge.puppetlabs.com/puppet/nginx)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/nginx.svg)](https://forge.puppetlabs.com/puppet/nginx)

This module was migrated from James Fryman <james@frymanet.com> to Vox Pupuli.

## INSTALLING OR UPGRADING

**Please note**: This module is undergoing some structural maintenance.
You may experience breaking changes between minor versions.

This module manages NGINX configuration.

### Requirements

* Puppet 4.6.1 or later.  Puppet 3 was supported up until release 0.6.0.
* apt is now a soft dependency. If your system uses apt, you'll need to configure an appropriate version of the apt module. Version 4.4.0 or higher is recommended because of the proper handling of `apt-transport-https`.

### Additional Documentation

* [A Quickstart Guide to the NGINX Puppet Module][quickstart]
  [quickstart]: <https://github.com/voxpupuli/puppet-nginx/blob/master/docs/quickstart.md>

### Install and bootstrap an NGINX instance

```puppet
include nginx
```

### A simple reverse proxy

```puppet
nginx::resource::server { 'kibana.myhost.com':
  listen_port => 80,
  proxy       => 'http://localhost:5601',
}
```

### A virtual host with static content

```puppet
nginx::resource::server { 'www.puppetlabs.com':
  www_root => '/var/www/www.puppetlabs.com',
}
```

### A more complex proxy example

```puppet
nginx::resource::upstream { 'puppet_rack_app':
  members => {
    'localhost:3000' => {
      server => 'localhost',
      port   => 3000,
      weight => 1,
    },
    'localhost:3001' => {
      server => 'localhost',
      port   => 3001,
      weight => 1,
    },
    'localhost:3002': => {
      server => 'localhost',
      port   => 3002,
      weight => 2,
      },
  },
}

nginx::resource::server { 'rack.puppetlabs.com':
  proxy => 'http://puppet_rack_app',
}
```

### Add a smtp proxy

```puppet
class { 'nginx':
  mail => true,
}

nginx::resource::mailhost { 'domain1.example':
  auth_http   => 'server2.example/cgi-bin/auth',
  protocol    => 'smtp',
  listen_port => 587,
  ssl_port    => 465,
  starttls    => 'only',
  xclient     => 'off',
  ssl         => true,
  ssl_cert    => '/tmp/server.crt',
  ssl_key     => '/tmp/server.pem',
}
```

### Convert upstream members from Array to Hash

The datatype Array for members of a nginx::resource::upstream is replaced by a Hash. The following configuration is no longer valid:

```puppet
nginx::resource::upstream { 'puppet_rack_app':
  members => {
    'localhost:3000',
    'localhost:3001',
    'localhost:3002',
  },
}
```

From now on, the configuration must look like this:

```puppet
nginx::resource::upstream { 'puppet_rack_app':
  members => {
    'localhost:3000' => {
      server => 'localhost',
      port   => 3000,
    },
    'localhost:3001' => {
      server => 'localhost',
      port   => 3001,
    },
    'localhost:3002' => {
      server => 'localhost',
      port   => 3002,
    },
  },
}
```

## SSL configuration

By default, creating a server resource will only create a HTTP server. To also
create a HTTPS (SSL-enabled) server, set `ssl => true` on the server. You will
have a HTTP server listening on `listen_port` (port `80` by default) and a HTTPS
server listening on `ssl_port` (port `443` by default). Both servers will have
the same `server_name` and a similar configuration.

To create only a HTTPS server, set `ssl => true` and also set `listen_port` to the
same value as `ssl_port`. Setting these to the same value disables the HTTP server.
The resulting server will be listening on `ssl_port`.

### Idempotency with nginx 1.15.0 and later

By default, this module might configure the deprecated `ssl on` directive.  When
you next run puppet, this will be removed since the `nginx_version` fact will now
be available. To avoid this idempotency issue, you can manually set the base
class's `nginx_version` parameter.

### Locations

Locations require specific settings depending on whether they should be included
in the HTTP, HTTPS or both servers.

#### HTTP only server (default)

If you only have a HTTP server (i.e. `ssl => false` on the server) make sure you
don't set `ssl => true` on any location you associate with the server.

#### HTTP and HTTPS server

If you set `ssl => true` and also set `listen_port` and `ssl_port` to different
values on the server you will need to be specific with the location settings since
you will have a HTTP server listening on `listen_port` and a HTTPS server listening
on `ssl_port`:

* To add a location to only the HTTP server, set `ssl => false` on the location
  (this is the default).
* To add a location to both the HTTP and HTTPS server, set `ssl => true` on the
  location, and ensure `ssl_only => false` (which is the default value for `ssl_only`).
* To add a location only to the HTTPS server, set both `ssl => true`
  and `ssl_only => true` on the location.

#### HTTPS only server

If you have set `ssl => true` and also set `listen_port` and `ssl_port` to the
same value on the server, you will have a single HTTPS server listening on
`ssl_port`. To add a location to this server set `ssl => true` and
`ssl_only => true` on the location.

## Hiera Support

Defining nginx resources in Hiera.

```yaml
nginx::nginx_upstreams:
  'puppet_rack_app':
    ensure: present
    members:
      'localhost:3000':
        server: 'localhost'
        port: 3000
      'localhost:3001':
        server: 'localhost'
        port: 3001
      'localhost:3002':
        server: 'localhost'
        port: 3002
nginx::nginx_servers:
  'www.puppetlabs.com':
    www_root: '/var/www/www.puppetlabs.com'
  'rack.puppetlabs.com':
    proxy: 'http://puppet_rack_app'
nginx::nginx_locations:
  'static':
    location: '~ "^/static/[0-9a-fA-F]{8}\/(.*)$"'
    server: www.puppetlabs.com
    www_root: /var/www/html
  'userContent':
    location: /userContent
    server: www.puppetlabs.com
    www_root: /var/www/html
nginx::nginx_mailhosts:
  'smtp':
    auth_http: server2.example/cgi-bin/auth
    protocol: smtp
    listen_port: 587
    ssl_port: 465
    starttls: only
```

### A stream syslog UDP proxy

```yaml

nginx::stream: true

nginx::nginx_cfg_prepend:
  include:
    - '/etc/nginx/modules-enabled/*.conf'

nginx::nginx_streamhosts:
  'syslog':
    ensure:                 'present'
    listen_port:            514
    listen_options:         'udp'
    proxy:                  'syslog'
    proxy_read_timeout:     '1'
    proxy_connect_timeout:  '1'
    raw_append:
      - 'error_log off;'

nginx::nginx_upstreams:
  'syslog':
    context: 'stream'
    members:
      '10.0.0.1:514':
        server: '10.0.0.1'
        port: 514
      '10.0.0.2:514':
        server: '10.0.0.2'
        port: 514
      '10.0.0.3:514':
        server: '10.0.0.3'
        port: 514
```

## Nginx with precompiled Passenger

Example configuration for Debian and RHEL / CentOS (>6), pulling the Nginx and
Passenger packages from the Phusion repo. See additional notes in
[https://github.com/voxpupuli/puppet-nginx/blob/master/docs/quickstart.md](https://github.com/voxpupuli/puppet-nginx/blob/master/docs/quickstart.md)

```puppet
class { 'nginx':
  package_source  => 'passenger',
  http_cfg_append => {
    'passenger_root' => '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
  }
}
```

Here the example for OpenBSD:

```puppet
class { 'nginx':
  package_flavor => 'passenger',
  service_flags  => '-u'
  http_cfg_append => {
    passenger_root          => '/usr/local/lib/ruby/gems/2.1/gems/passenger-4.0.44',
    passenger_ruby          =>  '/usr/local/bin/ruby21',
    passenger_max_pool_size => '15',
  }
}
```

Package source `passenger` will add [Phusion Passenger repository](https://oss-binaries.phusionpassenger.com/apt/passenger)
to APT sources. For each virtual host you should specify which ruby should be used.

```puppet
nginx::resource::server { 'www.puppetlabs.com':
  www_root          => '/var/www/www.puppetlabs.com',
  server_cfg_append => {
    'passenger_enabled' => 'on',
    'passenger_ruby'    => '/usr/bin/ruby',
  }
}
```

### Puppet master served by Nginx and Passenger

Virtual host config for serving puppet master:

```puppet
nginx::resource::server { 'puppet':
  ensure               => present,
  server_name          => ['puppet'],
  listen_port          => 8140,
  ssl                  => true,
  ssl_cert             => '/var/lib/puppet/ssl/certs/example.com.pem',
  ssl_key              => '/var/lib/puppet/ssl/private_keys/example.com.pem',
  ssl_port             => 8140,
  server_cfg_append    => {
    'passenger_enabled'      => 'on',
    'passenger_ruby'         => '/usr/bin/ruby',
    'ssl_crl'                => '/var/lib/puppet/ssl/ca/ca_crl.pem',
    'ssl_client_certificate' => '/var/lib/puppet/ssl/certs/ca.pem',
    'ssl_verify_client'      => 'optional',
    'ssl_verify_depth'       => 1,
  },
  www_root             => '/etc/puppet/rack/public',
  use_default_location => false,
  access_log           => '/var/log/nginx/puppet_access.log',
  error_log            => '/var/log/nginx/puppet_error.log',
  passenger_cgi_param  => {
    'HTTP_X_CLIENT_DN'     => '$ssl_client_s_dn',
    'HTTP_X_CLIENT_VERIFY' => '$ssl_client_verify',
  },
}
```

### Example puppet class calling nginx::server with HTTPS FastCGI and redirection of HTTP

```puppet

$full_web_path = '/var/www'

define web::nginx_ssl_with_redirect (
  $backend_port         = 9000,
  $php                  = true,
  $proxy                = undef,
  $www_root             = "${full_web_path}/${name}/",
  $location_cfg_append  = undef,
) {
  nginx::resource::server { "${name}.${::domain}":
    ensure              => present,
    www_root            => "${full_web_path}/${name}/",
    location_cfg_append => { 'rewrite' => '^ https://$server_name$request_uri? permanent' },
  }

  if !$www_root {
    $tmp_www_root = undef
  } else {
    $tmp_www_root = $www_root
  }

  nginx::resource::server { "${name}.${::domain} ${name}":
    ensure                => present,
    listen_port           => 443,
    www_root              => $tmp_www_root,
    proxy                 => $proxy,
    location_cfg_append   => $location_cfg_append,
    index_files           => [ 'index.php' ],
    ssl                   => true,
    ssl_cert              => '/path/to/wildcard_mydomain.crt',
    ssl_key               => '/path/to/wildcard_mydomain.key',
  }


  if $php {
    nginx::resource::location { "${name}_root":
      ensure          => present,
      ssl             => true,
      ssl_only        => true,
      server           => "${name}.${::domain} ${name}",
      www_root        => "${full_web_path}/${name}/",
      location        => '~ \.php$',
      index_files     => ['index.php', 'index.html', 'index.htm'],
      proxy           => undef,
      fastcgi         => "127.0.0.1:${backend_port}",
      fastcgi_script  => undef,
      location_cfg_append => {
        fastcgi_connect_timeout => '3m',
        fastcgi_read_timeout    => '3m',
        fastcgi_send_timeout    => '3m'
      }
    }
  }
}
```

## Add custom fastcgi_params

```puppet
nginx::resource::location { "some_root":
  ensure         => present,
  location       => '/some/url',
  fastcgi        => "127.0.0.1:9000",
  fastcgi_param  => {
    'APP_ENV' => 'local',
  },
}
```

# Call class web::nginx_ssl_with_redirect

```puppet
web::nginx_ssl_with_redirect { 'sub-domain-name':
    backend_port => 9001,
  }
```
