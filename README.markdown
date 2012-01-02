# NGINX Module

James Fryman <jamison@puppetlabs.com>

This module manages NGINX from within Puppet.

# Quick Start

Install and bootstrap an NGINX instance

    node default {
      class { 'nginx': }
    }

Setup a new virtual host

    node default {
      class { 'mcollective': }
      nginx::resource::vhost { 'www.puppetlabs.com':
        ensure   => present,
        www_root => '/var/www/www.puppetlabs.com',
      }
    }

Add a Proxy Server(s)

    node default {
      class { 'mcollective': }
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