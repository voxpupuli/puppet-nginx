# This definition creates a new location entry within a virtual host
#
# Sample Usage:
#  nginx::resource::location { 'test2.local-bob':
#    ensure   => present,
#    www_root => '/var/www/bob',
#    location => '/bob',
#    server   => 'test2.local',
#  }
#
#  Custom config example to limit location on localhost,
#  create a hash with any extra custom config you want.
#  $my_config = {
#    'access_log' => 'off',
#    'allow'      => '127.0.0.1',
#    'deny'       => 'all'
#  }
#  nginx::resource::location { 'test2.local-bob':
#    ensure              => present,
#    www_root            => '/var/www/bob',
#    location            => '/bob',
#    server              => 'test2.local',
#    location_cfg_append => $my_config,
#  }
#
#  Add Custom fastcgi_params
#  nginx::resource::location { 'test2.local-bob':
#    ensure        => present,
#    www_root      => '/var/www/bob',
#    location      => '/bob',
#    server        => 'test2.local',
#    fastcgi_param => {
#       'APP_ENV'  => 'local',
#    }
#  }
#
#  Add Custom uwsgi_params
#  nginx::resource::location { 'test2.local-bob':
#    ensure       => present,
#    www_root     => '/var/www/bob',
#    location     => '/bob',
#    server       => 'test2.local',
#    uwsgi_param  => {
#       'APP_ENV' => 'local',
#    }
#  }
#
# @param ensure
#  Enables or disables the specified location
# @param internal
#  Indicates whether or not this location can be
# @param location
#  Specifies the URI associated with this location
# @param server
#  Defines the default server for this location
# @param www_root
#  Specifies the location on disk for files to be
# @param autoindex
#  Set it on 'on' to activate autoindex directory
# @param index_files
#  Default index files for NGINX to read when
# @param proxy
#  Proxy server(s) for a location to connect to.
# @param proxy_redirect
#  sets the text, which must be changed in
# @param proxy_read_timeout
#  Override the default the proxy read timeout
# @param proxy_connect_timeout
#  Override the default the proxy connect timeout
# @param proxy_send_timeout
#  Override the default the proxy send timeout
# @param proxy_set_header
#  Array of server headers to set
# @param proxy_hide_header
#  Array of server headers to hide
# @param proxy_pass_header
#  Array of server headers to pass
# @param proxy_ignore_header
#  Array of server headers to ignore
# @param proxy_next_upstream
#  Specify cases a request should be passed to the next server in the upstream.
# @param fastcgi
#  location of fastcgi (host:port)
# @param fastcgi_index
# @param fastcgi_param
#  Set additional custom fastcgi_params
# @param fastcgi_params
#  optional alternative fastcgi_params file to use
# @param fastcgi_script
#  optional SCRIPT_FILE parameter
# @param fastcgi_split_path
#  Allows settings of fastcgi_split_path_info so
# @param uwsgi
#  location of uwsgi (host:port)
# @param uwsgi_param
#  Set additional custom uwsgi_params
# @param uwsgi_params
#  optional alternative uwsgi_params file to use
# @param uwsgi_read_timeout
#  optional value for uwsgi_read_timeout
# @param ssl
#  Indicates whether to setup SSL bindings for
# @param ssl_only
#  Required if the SSL and normal server have the
# @param location_alias
#  Path to be used as basis for serving requests
# @param location_satisfy
#  Allows access if all (all) or at least one (any) of the auth modules allow access.
# @param location_allow
#  Array: Locations to allow connections from.
# @param location_deny
#  Array: Locations to deny connections from.
# @param stub_status
#  If true it will point configure module
# @param raw_prepend
#  A single string, or an array of strings to
# @param raw_append
#  A single string, or an array of strings to
# @param location_custom_cfg
#  Expects a hash with custom directives, cannot
# @param location_cfg_prepend
#  Expects a hash with extra directives to put
# @param location_cfg_append
#  Expects a hash with extra directives to put
# @param location_custom_cfg_prepend
#  Expects a array with extra directives
# @param location_custom_cfg_append
#  Expects a array with extra directives
# @param include
#  An array of files to include for this location
# @param try_files
#  An array of file locations to try
# @param proxy_cache
#  This directive sets name of zone for caching.
# @param proxy_cache_key
#  Override the default proxy_cache_key of
# @param proxy_cache_use_stale
#  Override the default proxy_cache_use_stale value
# @param proxy_cache_lock
#  This directive sets the locking mechanism for pouplating cache.
# @param proxy_cache_valid
#  This directive sets the time for caching
# @param proxy_cache_bypass
#  Defines conditions which the response will not be cached
# @param proxy_method
#  If defined, overrides the HTTP method of the
# @param proxy_http_version
#  Sets the proxy http version
# @param proxy_set_body
#  If defined, sets the body passed to the backend.
# @param proxy_buffering
#  If defined, sets the proxy_buffering to the passed
# @param absolute_redirect
#  Enables or disables the absolute redirect functionality of nginx
# @param auth_basic
#  This directive includes testing name and password
# @param auth_basic_user_file
#  This directive sets the htpasswd filename for
# @param auth_request
#  This allows you to specify a custom auth endpoint
# @param rewrite_rules
# @param priority
#  Location priority. Default: 500. User priority
# @param mp4
#  Indicates whether or not this loation can be
# @param flv
#  Indicates whether or not this loation can be
# @param expires
#  Setup expires time for locations content
# @param add_header
#  Hash: Adds headers to the location block.  If any are specified, locations will no longer inherit headers from the parent server context
define nginx::resource::location (
  Enum['present', 'absent'] $ensure                    = present,
  Boolean $internal                                    = false,
  String $location                                     = $name,
  String $server                                       = undef,
  Optional[String] $www_root                           = undef,
  Optional[String] $autoindex                          = undef,
  Array $index_files                                   = [
    'index.html',
    'index.htm',
    'index.php'],
  Optional[String] $proxy                              = undef,
  Optional[String] $proxy_redirect                     = $nginx::proxy_redirect,
  String $proxy_read_timeout                           = $nginx::proxy_read_timeout,
  String $proxy_connect_timeout                        = $nginx::proxy_connect_timeout,
  String $proxy_send_timeout                           = $nginx::proxy_send_timeout,
  Array $proxy_set_header                              = $nginx::proxy_set_header,
  Array $proxy_hide_header                             = $nginx::proxy_hide_header,
  Array $proxy_pass_header                             = $nginx::proxy_pass_header,
  Array $proxy_ignore_header                           = $nginx::proxy_ignore_header,
  Optional[String] $proxy_next_upstream                = undef,
  Optional[String] $fastcgi                            = undef,
  Optional[String] $fastcgi_index                      = undef,
  Optional[Hash] $fastcgi_param                        = undef,
  String $fastcgi_params                               = "${nginx::conf_dir}/fastcgi.conf",
  Optional[String] $fastcgi_script                     = undef,
  Optional[String] $fastcgi_split_path                 = undef,
  Optional[String] $uwsgi                              = undef,
  Optional[Hash] $uwsgi_param                          = undef,
  String $uwsgi_params                                 = "${nginx::config::conf_dir}/uwsgi_params",
  Optional[String] $uwsgi_read_timeout                 = undef,
  Boolean $ssl                                         = false,
  Boolean $ssl_only                                    = false,
  Optional[String] $location_alias                     = undef,
  Optional[Enum['any', 'all']] $location_satisfy       = undef,
  Optional[Array] $location_allow                      = undef,
  Optional[Array] $location_deny                       = undef,
  Optional[Boolean ] $stub_status                      = undef,
  Optional[Variant[String, Array]] $raw_prepend        = undef,
  Optional[Variant[String, Array]] $raw_append         = undef,
  Optional[Hash] $location_custom_cfg                  = undef,
  Optional[Hash] $location_cfg_prepend                 = undef,
  Optional[Hash] $location_cfg_append                  = undef,
  Optional[Hash] $location_custom_cfg_prepend          = undef,
  Optional[Hash] $location_custom_cfg_append           = undef,
  Optional[Array] $include                             = undef,
  Optional[Array] $try_files                           = undef,
  Optional[String] $proxy_cache                        = undef,
  Optional[String] $proxy_cache_key                    = undef,
  Optional[String] $proxy_cache_use_stale              = undef,
  Optional[Enum['on', 'off']] $proxy_cache_lock        = undef,
  Optional[Variant[Array, String]] $proxy_cache_valid  = undef,
  Optional[Variant[Array, String]] $proxy_cache_bypass = undef,
  Optional[String] $proxy_method                       = undef,
  Optional[String] $proxy_http_version                 = undef,
  Optional[String] $proxy_set_body                     = undef,
  Optional[Enum['on', 'off']] $proxy_buffering         = undef,
  Optional[Enum['on', 'off']] $absolute_redirect       = undef,
  Optional[String] $auth_basic                         = undef,
  Optional[String] $auth_basic_user_file               = undef,
  Optional[String] $auth_request                       = undef,
  Array $rewrite_rules                                 = [],
  Integer[401,599] $priority                           = 500,
  Boolean $mp4                                         = false,
  Boolean $flv                                         = false,
  Optional[String] $expires                            = undef,
  Hash $add_header                                     = {},
) {

  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  $root_group = $nginx::root_group

  File {
    owner  => 'root',
    group  => $root_group,
    mode   => '0644',
    notify => Class['::nginx::service'],
  }

  # # Shared Variables
  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => file,
  }

  if ($www_root and $proxy) {
    fail("Cannot define both directory and proxy in ${server}:${title}")
  }

  # Use proxy, fastcgi or uwsgi template if $proxy is defined, otherwise use directory template.
  # fastcgi_script is deprecated
  if ($fastcgi_script != undef) {
    warning('The $fastcgi_script parameter is deprecated; please use $fastcgi_param instead to define custom fastcgi_params!')
  }

  $server_sanitized = regsubst($server, ' ', '_', 'G')
  if $nginx::confd_only {
    $server_dir = "${nginx::conf_dir}/conf.d"
  } else {
    $server_dir = "${nginx::conf_dir}/sites-available"
  }

  $config_file = "${server_dir}/${server_sanitized}.conf"

  # Only try to manage these files if they're the default one (as you presumably
  # usually don't want the default template if you're using a custom file.

  if  (
    $ensure == present              and
    $fastcgi != undef               and
    !defined(File[$fastcgi_params]) and
    $fastcgi_params == "${nginx::conf_dir}/fastcgi.conf"
      ) {
    file { $fastcgi_params:
      ensure  => present,
      mode    => '0644',
      content => template('nginx/server/fastcgi.conf.erb'),
    }
  }

  if $ensure == present and $uwsgi != undef and !defined(File[$uwsgi_params]) and $uwsgi_params == "${nginx::conf_dir}/uwsgi_params" {
    file { $uwsgi_params:
      ensure  => present,
      mode    => '0644',
      content => template('nginx/server/uwsgi_params.erb'),
    }
  }

  if $ensure == present {
    ## Create stubs for server File Fragment Pattern
    $location_md5 = md5($location)
    if ($ssl_only != true) {
      concat::fragment { "${server_sanitized}-${priority}-${location_md5}":
        target  => $config_file,
        content => template('nginx/server/location.erb'),
        order   => $priority,
      }
    }

    ## Only create SSL Specific locations if $ssl is true.
    if ($ssl == true or $ssl_only == true) {
      $ssl_priority = $priority + 300

      concat::fragment { "${server_sanitized}-${ssl_priority}-${location_md5}-ssl":
        target  => $config_file,
        content => template('nginx/server/location.erb'),
        order   => $ssl_priority,
      }
    }
  }
}
