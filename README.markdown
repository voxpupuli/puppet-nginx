#nginx

[![Build Status](https://travis-ci.org/jfryman/puppet-nginx.png)](https://travis-ci.org/jfryman/puppet-nginx)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nginx](#setup)
    * [What nginx affects](#what-nginx-affects)
    * [Beginning with nginx](#beginning-with-nginx)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Classes and Defined Types](#classes-and-defined-types)
      * [Class: nginx](#class-nginx)
      * [Defined Type: nginx::resource::vhost](#defined-type-nginxresourcevhost)
      * [Defined Type: nginx::resource::location](#defined-type-nginxresourcelocation)
      * [Defined Type: nginx::resource::geo](#defined-type-nginxresourcegeo)
      * [Defined Type: nginx::resource::mailhost](#defined-type-nginxresourcemailhost)
      * [Defined Type: nginx::resource::map](#defined-type-nginxresourcemap)
   * [Load Balancing](#load-balancing)
      * [Defined Type: nginx::resource::upstream](#defined-type-nginxresourceupstream)
      * [Defined Type: nginx::resource::upstream::member](#defined-type-nginxresourceupstreammember)
   * [SSL Configuration](#ssl-configuration)
   * [nginx with precompiled Passenger](#nginx-with-precompiled-passenger)
   * [Hiera Support](#hiera-support)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
      * [Public Classes](#public-classes)
      * [Private Classes](#private-classes)
    * [Defined Types](#defined-types)
      * [Public Defined Types](#public-defined-types)
      * [Private Defined Types](#private-defined-types)
    * [Templates](#templates)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module manages nginx configuration. 

##Module Description

nginx is a popular HTTP and reverse proxy server, as well as a mail proxy server. This module installs the nginx package(s) on various platforms, configures the nginx service, and allows for configuration of servers and mail proxies.

##Setup

###What nginx affects

* configuration files and directories
* package/service/configuration files for nginx
* nginx servers (virtual hosts)

###Beginning with nginx	

#### Install and bootstrap an nginx instance

```puppet
class { 'nginx': }
```

#### Setup a new virtual host

```puppet
nginx::resource::vhost { 'www.puppetlabs.com':
  www_root => '/var/www/www.puppetlabs.com',
}
```

##Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

###Classes and Defined Types

####Class: `nginx`

#####Parameters within `nginx`:

**Please help document these!**

######`client_body_buffer_size`
######`client_body_temp_path`
######`client_max_body_size`
######`conf_dir`
######`conf_template`
######`confd_purge`
######`configtest_enable`
######`daemon_user`
######`events_use`
######`fastcgi_cache_inactive`
######`fastcgi_cache_key`
######`fastcgi_cache_keys_zone`
######`fastcgi_cache_levels`
######`fastcgi_cache_max_size`
######`fastcgi_cache_path`
######`fastcgi_cache_use_stale`
######`geo_mappings`
######`global_group`
######`global_mode`
######`global_owner`
######`gzip`
######`http_access_log`
######`http_cfg_append`
######`http_tcp_nodelay`
######`http_tcp_nopush`
######`keepalive_timeout`
######`logdir`
######`mail`
######`manage_repo`
######`multi_accept`
######`names_hash_bucket_size`
######`names_hash_max_size`
######`nginx_error_log`
######`nginx_locations`
######`nginx_mailhosts`
######`nginx_upstreams`
######`nginx_vhosts`
######`nginx_vhosts_defaults`
######`package_ensure`
######`package_name`
######`package_source`
######`pid`
######`proxy_buffer_size`
######`proxy_buffers`
######`proxy_cache_inactive`
######`proxy_cache_keys_zone`
######`proxy_cache_levels`
######`proxy_cache_max_size`
######`proxy_cache_path`
######`proxy_conf_template`
######`proxy_connect_timeout`
######`proxy_headers_hash_bucket_size`
######`proxy_http_version`
######`proxy_read_timeout`
######`proxy_redirect`
######`proxy_send_timeout`
######`proxy_set_header`
######`proxy_temp_path`
######`run_dir`
######`sendfile`
######`server_tokens`
######`service_ensure`
######`service_restart`
######`sites_available_group`
######`sites_available_mode`
######`sites_available_owner`
######`spdy`
######`string_mappings`
######`super_user`
######`temp_dir`
######`types_hash_bucket_size`
######`types_hash_max_size`
######`vhost_purge`
######`worker_connections`
######`worker_processes`
######`worker_rlimit_nofile`


####Defined Type: `nginx::resource::vhost`

Sample usage:

```puppet
nginx::resource::vhost { 'test2.local':
  ensure   => present,
  www_root => '/var/www/nginx-default',
  ssl      => true,
  ssl_cert => '/tmp/server.crt',
  ssl_key  => '/tmp/server.pem',
}
```

#####Parameters within `nginx::resource::vhost`:

**Please help document these!**

######`access_log`
Where to write access log. May add additional options like log format to the end.

######`add_header`
Hash: Adds headers to the HTTP response when response code is equal to 200, 204, 301, 302 or 304.

######`auth_basic`
This directive includes testing name and password with HTTP Basic Authentication.

######`auth_basic_user_file`
This directive sets the htpasswd filename for the authentication realm.

######`autoindex`
Set it on 'on' or 'off 'to activate/deactivate autoindex directory listing. Undef by default.

######`client_body_timeout`
Sets how long the server will wait for a client body. Default is 60s

######`client_header_timeout`
Sets how long the server will wait for a client header. Default is 60s

######`client_max_body_size`
This directive sets client_max_body_size.

######`ensure`
Enables or disables the specified vhost (present|absent)

######`error_log`
Where to write error log. May add additional options like error level to the end.

######`fastcgi`
location of fastcgi (host:port)

######`fastcgi_params`
optional alternative fastcgi_params file to use

######`fastcgi_script`
optional SCRIPT_FILE parameter

######`format_log`

######`geo_mappings`

######`group`
Defines group of the .conf file

######`gzip_types`
Defines gzip_types, nginx default is text/html

######`include_files`
Adds include files to vhost

######`index_files`
Default index files for NGINX to read when traversing a directory

######`ipv6_enable`
BOOL value to enable/disable IPv6 support (false|true). Module will check to see if IPv6 support exists on your system before enabling.

######`ipv6_listen_ip`
Default IPv6 Address for NGINX to listen with this vHost on. Defaults to all interfaces (::)

######`ipv6_listen_options`
Extra options for listen directive like 'default' to catchall. Default value is 'default ipv6only=on'.

######`ipv6_listen_port`
Default IPv6 Port for NGINX to listen with this vHost on. Defaults to TCP 80

######`listen_ip`
Default IP Address for NGINX to listen with this vHost on. Defaults to all interfaces (*)

######`listen_options`
Extra options for listen directive like 'default' to catchall. Undef by default.

######`listen_port`
Default IP Port for NGINX to listen with this vHost on. Defaults to TCP 80

######`location_allow`
Array: Locations to allow connections from.

######`location_cfg_append`
It expects a hash with custom directives to put after everything else inside vhost

######`location_cfg_prepend`
It expects a hash with custom directives to put before everything else inside vhost

######`location_custom_cfg`

######`location_custom_cfg_append`

######`location_custom_cfg_prepend`

######`location_deny`
Array: Locations to deny connections from.

######`location_raw_append`
A single string, or an array of strings to append to the location directive (after custom_cfg directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`location_raw_prepend`
A single string, or an array of strings to prepend to the location directive (after custom_cfg directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`log_by_lua`
Run the Lua source code inlined as the <lua-script-str> at the log request processing phase. This does not replace the current access logs, but runs after.

######`log_by_lua_file`
Equivalent to `log_by_lua`, except that the file specified by <path-to-lua-script-file> contains the Lua code, or, as from the v0.5.0rc32 release, the Lua/LuaJIT bytecode to be executed.

######`mode`
Defines mode of the .conf file

######`owner`
Defines owner of the .conf file

######`passenger_cgi_param`
Allows one to define additional CGI environment variables to pass to the backend application

######`proxy`
Proxy server(s) for the root location to connect to.  Accepts a single value, can be used in conjunction with `nginx::resource::upstream`.

######`proxy_cache`
This directive sets name of zone for caching. The same zone can be used in multiple places.

######`proxy_cache_valid`
This directive sets the time for caching different replies.

######`proxy_connect_timeout`

######`proxy_method`
If defined, overrides the HTTP method of the request to be passed to the backend.

######`proxy_read_timeout`
Override the default the proxy read timeout value of 90 seconds

######`proxy_redirect`
Override the default proxy_redirect value of off.

######`proxy_set_body`
If defined, sets the body passed to the backend.

######`proxy_set_header`

######`raw_append`
A single string, or an array of strings to append to the server directive (after cfg append directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`raw_prepend`
A single string, or an array of strings to prepend to the server directive (after cfg prepend directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`resolver`
Array: Configures name servers used to resolve names of upstream servers into addresses.

######`rewrite_rules`

######`rewrite_to_https`
Adds a server directive and rewrite rule to rewrite to ssl.

######`rewrite_www_to_non_www`
Adds a server directive and rewrite rule to rewrite www.domain.com to domain.com in order to avoid duplicate content (SEO).

######`server_name`
List of vhostnames for which this vhost will respond. Default `[$name]`.

######`spdy`
Toggles SPDY protocol.

######`ssl`
Indicates whether to setup SSL bindings for this vhost.

######`ssl_cache`

######`ssl_cert`
Pre-generated SSL Certificate file to reference for SSL Support. This is not generated by this module.

######`ssl_ciphers`
SSL ciphers enabled. Defaults to 'HIGH:!aNULL:!MD5'.

######`ssl_dhparam`
This directive specifies a file containing Diffie-Hellman key agreement protocol cryptographic parameters, in PEM format, utilized for exchanging session keys between server and client.

######`ssl_key`
Pre-generated SSL Key file to reference for SSL support. This is not generated by this module.

######`ssl_listen_option`

######`ssl_port`
Default IP Port for NGINX to listen with this SSL vHost on. Defaults to TCP 443

######`ssl_protocols`
SSL protocols enabled. Defaults to 'SSLv3 TLSv1 TLSv1.1 TLSv1.2'.

######`ssl_session_timeout`
String: Specifies a time during which a client may reuse the session parameters stored in a cache. Defaults to 5m.

######`ssl_stapling`
Bool: Enables or disables stapling of OCSP responses by the server. Defaults to false.

######`ssl_stapling_file`
String: When set, the stapled OCSP response will be taken from the specified file instead of querying the OCSP responder specified in the server certificate.

######`ssl_stapling_responder`
String: Overrides the URL of the OCSP responder specified in the Authority Information Access certificate extension.

######`ssl_stapling_verify`
Bool: Enables or disables verification of OCSP responses by the server. Defaults to false.

######`ssl_trusted_cert`
String: Specifies a file with trusted CA certificates in the PEM format used to verify client certificates and OCSP responses if ssl_stapling is enabled.

######`string_mappings`

######`try_files`
Specifies the locations for files to be checked as an array. Cannot be used in conjuction with `proxy`.

######`use_default_location`

######`vhost_cfg_append`

######`vhost_cfg_prepend`

######`vhost_cfg_ssl_append`
It expects a hash with custom directives to put after everything else inside vhost ssl

######`vhost_cfg_ssl_prepend`
It expects a hash with custom directives to put before everything else inside vhost ssl

######`www_root`
Specifies the location on disk for files to be read from. Cannot be set in conjunction with `proxy`

####Defined Type: `nginx::resource::location`

Sample usage:

```puppet
nginx::resource::location { 'test2.local-bob':
  ensure   => present,
  www_root => '/var/www/bob',
  location => '/bob',
  vhost    => 'test2.local',
}
```

Custom config example to limit location on localhost, create a hash with any extra custom config you want.
```puppet
$my_config = {
  'access_log' => 'off',
  'allow'      => '127.0.0.1',
  'deny'       => 'all'
}
nginx::resource::location { 'test2.local-bob':
  ensure              => present,
  www_root            => '/var/www/bob',
  location            => '/bob',
  vhost               => 'test2.local',
  location_cfg_append => $my_config,
}
```

Add Custom fastcgi_params
```puppet
nginx::resource::location { 'test2.local-bob':
  ensure   => present,
  www_root => '/var/www/bob',
  location => '/bob',
  vhost    => 'test2.local',
  fastcgi_param => {
    'APP_ENV' => 'local',
  }
}
```

#####Parameters within `nginx::resource::location`:

**Please help document these!**

######`auth_basic`
This directive includes testing name and password with HTTP Basic Authentication.

######`auth_basic_user_file`
This directive sets the htpasswd filename for the authentication realm.

######`autoindex`
Set it on 'on' to activate autoindex directory listing. Undef by default.

######`ensure`
Enables or disables the specified location (present|absent)

######`fastcgi`
location of fastcgi (host:port)

######`fastcgi_param`
Set additional custom fastcgi_params

######`fastcgi_params`
optional alternative fastcgi_params file to use

######`fastcgi_script`
optional SCRIPT_FILE parameter

######`fastcgi_split_path`
Allows settings of fastcgi_split_path_info so that you can split the script_name and path_info via regex

######`flv`
Indicates whether or not this loation can be used for flv streaming. Default: false

######`index_files`
Default index files for NGINX to read when traversing a directory

######`internal`
Indicates whether or not this loation can be used for internal requests only. Default: false

######`location`
Specifies the URI associated with this location entry

######`location_alias`
Path to be used as basis for serving requests for this location

######`location_allow`
Array: Locations to allow connections from.

######`location_cfg_append`
Expects a hash with extra directives to put after everything else inside location (used with all other types except custom_cfg)

######`location_cfg_prepend`
Expects a hash with extra directives to put before anything else inside location (used with all other types except custom_cfg)

######`location_custom_cfg`
Expects a hash with custom directives, cannot be used with other location types (proxy, fastcgi, root, or stub_status)

######`location_custom_cfg_append`
Expects a array with extra directives to put after anything else inside location (used with all other types except custom_cfg). Used for logical structures such as if.

######`location_custom_cfg_prepend`
Expects a array with extra directives to put before anything else inside location (used with all other types except custom_cfg). Used for logical structures such as if.

######`location_deny`
Array: Locations to deny connections from.

######`mp4`
Indicates whether or not this loation can be used for mp4 streaming. Default: false

######`option`
Reserved for future use

######`priority`
Location priority. Default: 500. User priority 401-499, 501-599. If the priority is higher than the default priority, the location will be defined after root, or before root.

######`proxy`
Proxy server(s) for a location to connect to. Accepts a single value, can be used in conjunction with nginx::resource::upstream

######`proxy_cache`
This directive sets name of zone for caching. The same zone can be used in multiple places.

######`proxy_cache_valid`
This directive sets the time for caching different replies.

######`proxy_connect_timeout`
Override the default the proxy connect timeout value of 90 seconds

######`proxy_method`
If defined, overrides the HTTP method of the request to be passed to the backend.

######`proxy_read_timeout`
Override the default the proxy read timeout value of 90 seconds

######`proxy_redirect`
Sets the text, which must be changed in response-header "Location" and "Refresh" in the response of the proxied server.

######`proxy_set_body`
If defined, sets the body passed to the backend.

######`proxy_set_header`
Array of vhost headers to set

######`raw_append`
A single string, or an array of strings to append to the location directive (after custom_cfg directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`raw_prepend`
A single string, or an array of strings to prepend to the location directive (after custom_cfg directives). NOTE: YOU are responsible for a semicolon on each line that requires one.

######`rewrite_rules`


######`ssl`
Indicates whether to setup SSL bindings for this location.

######`ssl_only`
Required if the SSL and normal vHost have the same port.

######`stub_status`
If true it will point configure module stub_status to provide nginx stats on location

######`try_files`
An array of file locations to try

######`vhost`
Defines the default vHost for this location entry to include with

######`www_root`
Specifies the location on disk for files to be read from. Cannot be set in conjunction with `proxy`

####Defined Type: `nginx::resource::geo`

Sample usage:

```puppet
nginx::resource::geo { 'client_network':
  ensure          => present,
  ranges          => false,
  default         => extra,
  proxy_recursive => false,
  proxies         => [ '192.168.99.99' ],
  networks        => {
    '10.0.0.0/8'     => 'intra',
    '172.16.0.0/12'  => 'intra',
    '192.168.0.0/16' => 'intra',
  }
}
```

#####Parameters within `nginx::resource::geo`:

**Please help document these!**

######`address`
Nginx defaults to using $remote_addr for testing. This allows you to override that with another variable name (automatically prefixed with $)

######`default`
Sets the resulting value if the source value fails to match any of the variants.

######`delete`
Deletes the specified network (see: geo module docs)

######`ensure`
Enables or disables the specified location

######`networks`
Hash of geo lookup keys and resultant values

######`proxies`
Hash of network->value mappings.

######`proxy_recursive`
Changes the behavior of address acquisition when specifying trusted proxies via 'proxies' directive

######`ranges`
Indicates that lookup keys (network addresses) are specified as ranges.

####Defined Type: `nginx::resource::mailhost`

Sample usage - add a SMTP proxy:

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

#####Parameters within `nginx::resource::mailhost`:

**Please help document these!**

######`auth_http`
With this directive you can set the URL to the external HTTP-like server for authorization.

######`ensure`
Enables or disables the specified mailhost (present|absent)

######`ipv6_enable`
BOOL value to enable/disable IPv6 support (false|true). Module will check to see if IPv6 support exists on your system before enabling.

######`ipv6_listen_ip`
Default IPv6 Address for NGINX to listen with this vHost on. Defaults to all interfaces (::)

######`ipv6_listen_options`
Extra options for listen directive like 'default' to catchall. Template will allways add ipv6only=on. While issue jfryman/puppet-nginx#30 is discussed, default value is 'default'.

######`ipv6_listen_port`
Default IPv6 Port for NGINX to listen with this vHost on. Defaults to TCP 80

######`listen_ip`
Default IP Address for NGINX to listen with this vHost on. Defaults to all interfaces (*)

######`listen_options`
Extra options for listen directive like 'default' to catchall. Undef by default.

######`listen_port`
Default IP Port for NGINX to listen with this vHost on. Defaults to TCP 80

######`protocol`
Mail protocol to use: (imap|pop3|smtp)

######`server_name`
List of mailhostnames for which this mailhost will respond. Default [$name].

######`ssl`
Indicates whether to setup SSL bindings for this mailhost.

######`ssl_cert`
Pre-generated SSL Certificate file to reference for SSL Support. This is not generated by this module.

######`ssl_key`
Pre-generated SSL Key file to reference for SSL Support. This is not generated by this module.

######`ssl_port`
Default IP Port for NGINX to listen with this SSL vHost on. Defaults to TCP 443

######`starttls`
enable STARTTLS support: (on|off|only)

######`xclient`
wheter to use xclient for smtp (on|off)

####Defined Type: `nginx::resource::map`

Sample Usage:

```puppet
nginx::resource::map { 'backend_pool':
  ensure    => present,
  hostnames => true,
  default   => 'ny-pool-1,
  string    => '$http_host',
  mappings  => {
    '*.nyc.example.com' => 'ny-pool-1',
    '*.sf.example.com'  => 'sf-pool-1',
  }
}
```

#####Parameters within `nginx::resource::map`:

**Please help document these!**

######`default`
Sets the resulting value if the source values fails to match any of the variants.

######`ensure`
Enables or disables the specified location (present|absent)

######`hostnames`
Indicates that source values can be hostnames with a prefix or suffix mask.

######`mappings`
Hash of map lookup keys and resultant values

######`string`
Source string or variable to provide mapping for.

###Load Balancing

####Defined Type: `nginx::resource::upstream`

Sample usage:

```puppet
nginx::resource::upstream { 'puppet_rack_app':
  members => [
    'localhost:3000',
    'localhost:3001',
    'localhost:3002',
  ],
}

nginx::resource::vhost { 'rack.puppetlabs.com':
  proxy => 'http://puppet_rack_app',
}
```

Custom config example to use ip_hash, and 20 keepalive connections. Create a hash with any extra custom config you want.
```puppet
$my_config = {
  'ip_hash'   => '',
  'keepalive' => '20',
}
nginx::resource::upstream { 'proxypass':
  ensure               => present,
  members              => [
    'localhost:3000',
    'localhost:3001',
    'localhost:3002',
  ],
  upstream_cfg_prepend => $my_config,
}
```

#####Parameters within `nginx::resource::upstream`:

**Please help document these!**

######`ensure`
Enables or disables the specified location (present|absent)

######`members`
Array of member URIs for NGINX to connect to. Must follow valid NGINX syntax. If omitted, individual members should be defined with `nginx::resource::upstream::member`

######`upstream_cfg_prepend`
It expects a hash with custom directives to put before anything else inside upstream

######`upstream_fail_timeout`
Set the fail_timeout for the upstream. Default is 10 seconds - As that is what Nginx does normally.

####Defined Type: `nginx::resource::upstream::member`

#####Parameters within `nginx::resource::upstream::member`:

**Please help document these!**

######`port`
Port of the listening service on the upstream member

######`server`
Hostname or IP of the upstream member server

######`upstream_fail_timeout`
Set the fail_timeout for the upstream. Default is 10 seconds

######`upstream`
The name of the upstream resource

### SSL configuration

By default, creating a vhost resource will only create a HTTP vhost. To also create a HTTPS (SSL-enabled) vhost, set `ssl => true` on the vhost. You will have a HTTP server listening on `listen_port` (port `80` by default) and a HTTPS server listening on `ssl_port` (port `443` by default). Both vhosts will have the same `server_name` and a similar configuration.

To create only a HTTPS vhost, set `ssl => true` and also set `listen_port` to the same value as `ssl_port`. Setting these to the same value disables the HTTP vhost. The resulting vhost will be listening on `ssl_port`.

#### Locations

Locations require specific settings depending on whether they should be included in the HTTP, HTTPS or both vhosts.

##### HTTP only vhost (default)
If you only have a HTTP vhost (i.e. `ssl => false` on the vhost) make sure you don't set `ssl => true` on any location you associate with the vhost.

##### HTTP and HTTPS vhost
If you set `ssl => true` and also set `listen_port` and `ssl_port` to different values on the vhost you will need to be specific with the location settings since you will have a HTTP vhost listening on `listen_port` and a HTTPS vhost listening on `ssl_port`:

* To add a location to only the HTTP server, set `ssl => false` on the location (this is the default).
* To add a location to both the HTTP and HTTPS server, set `ssl => true` on the location, and ensure `ssl_only => false` (which is the default value for `ssl_only`).
* To add a location only to the HTTPS server, set both `ssl => true` and `ssl_only => true` on the location.

##### HTTPS only vhost
If you have set `ssl => true` and also set `listen_port` and `ssl_port` to the same value on the vhost, you will have a single HTTPS vhost listening on `ssl_port`. To add a location to this vhost set `ssl => true` and `ssl_only => true` on the location.

###nginx with precompiled Passenger

**NOTE:** Currently this works only for Debian family.

```puppet
class { 'nginx':
  package_source  => 'passenger',
  http_cfg_append => {
    'passenger_root' => '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
  }
}
```

Package source `passenger` will add [Phusion Passenger repository](https://oss-binaries.phusionpassenger.com/apt/passenger) to APT sources.
For each virtual host you should specify which ruby should be used.

```puppet
nginx::resource::vhost { 'www.puppetlabs.com':
  www_root         => '/var/www/www.puppetlabs.com',
  vhost_cfg_append => {
    'passenger_enabled' => 'on',
    'passenger_ruby'    => '/usr/bin/ruby',
  }
}
```

### Hiera Support

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
    proxy: 'http://puppet_rack_app'
nginx::nginx_locations:
  'static':
    location: '~ "^/static/[0-9a-fA-F]{8}\/(.*)$"'
    vhost: www.puppetlabs.com
  'userContent':
    location: /userContent
    vhost: www.puppetlabs.com
    www_root: /var/www/html
nginx::nginx_mailhosts:
  'smtp':
    auth_http: server2.example/cgi-bin/auth
    protocol: smtp
    listen_port: 587
    ssl_port: 465
    starttls: only
```

##Reference

###Classes
####Public Classes
* [`nginx`](#class-nginx): Guides the basic setup of nginx.

####Private Classes
* `nginx::config`: Configures the nginx package & daemon.
* `nginx::package`: Loads the appropriate package class depending on the OS in use.
   * `nginx::package::archlinux`: Installs the nginx package on Arch Linux.
   * `nginx::package::debian`: Installs the nginx package on Debian family distros.
   * `nginx::package::freebsd`: Installs the nginx package on FreeBSD.
   * `nginx::package::redhat`: Installs the nginx package on Red Hat family distors.
   * `nginx::package::solaris`: Installs the nginx package on Solaris.
   * `nginx::package::suse`: Installs the nginx package on SuSE family distros.
* `nginx::params`: Manages nginx parameters.
* `nginx::service`: Manages the nginx daemon.


###Defined Types
####Public Defined Types
* `nginx::resource::vhost`: This definition creates a virtual host.
* `nginx::resource::location`: This definition creates a new location entry within a virtual host.
* `nginx::resource::geo`: This definition creates a new geo mapping entry for nginx.
* `nginx::resource::mailhost`: This definition creates a SMTP proxy.
* `nginx::resource::map`: This definition creates a new mapping entry for nginx.
* `nginx::resource::upstream`: This definition creates a new upstream proxy entry for nginx.
* `nginx::resource::upstream::member`: Creates an upstream member inside the upstream block. Export this resource in all upstream member servers and collect them on the nginx server.

####Private Defined Types
N/A

###Templates

##Limitations

* Puppet-2.7.0 or later
* Ruby-1.9.3 or later (Support for Ruby-1.8.7 is not guaranteed. YMMV).

##Development

Please refer to [CONTRIBUTING.md](CONTRIBUTING.md)
