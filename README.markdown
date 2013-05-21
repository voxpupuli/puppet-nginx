# NGINX Module

James Fryman <james@frymanet.com>

This module manages NGINX from within Puppet.

# Quick Start

Install and bootstrap an NGINX instance

<pre>
    node default {
      class { 'nginx': }
    }
</pre>

Setup a new virtual host

<pre>
    node default {
      class { 'nginx': }
      nginx::resource::vhost { 'www.puppetlabs.com':
        ensure   => present,
        www_root => '/var/www/www.puppetlabs.com',
      }
    }
</pre>

Add a Proxy Server(s)
<pre>
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
</pre>

Add an smtp proxy
<pre>
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
</pre>
