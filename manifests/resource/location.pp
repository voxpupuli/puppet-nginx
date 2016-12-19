# define: nginx::resource::location
#
# This definition creates a new location entry within a virtual host
#
# Parameters:
#   [*ensure*]               - Enables or disables the specified location
#     (present|absent)
#   [*internal*]             - Indicates whether or not this loation can be
#     used for internal requests only. Default: false
#   [*server*]                - Defines the default server for this location
#     entry to include with
#   [*location*]             - Specifies the URI associated with this location
#     entry
#   [*location_satisfy*]    - Allows access if all (all) or at least one (any) of the auth modules allow access.
#   [*location_allow*]       - Array: Locations to allow connections from.
#   [*location_deny*]        - Array: Locations to deny connections from.
#   [*www_root*]             - Specifies the location on disk for files to be
#     read from. Cannot be set in conjunction with $proxy
#   [*autoindex*]            - Set it on 'on' to activate autoindex directory
#     listing. Undef by default.
#   [*index_files*]          - Default index files for NGINX to read when
#     traversing a directory
#   [*proxy*]                - Proxy server(s) for a location to connect to.
#     Accepts a single value, can be used in conjunction with
#     nginx::resource::upstream
#   [*proxy_redirect*]       - sets the text, which must be changed in
#     response-header "Location" and "Refresh" in the response of the proxied
#     server.
#   [*proxy_read_timeout*]   - Override the default the proxy read timeout
#     value of 90 seconds
#   [*proxy_connect_timeout*] - Override the default the proxy connect timeout
#     value of 90 seconds
#   [*proxy_set_header*]     - Array of server headers to set
#   [*proxy_hide_header*]    - Array of server headers to hide
#   [*proxy_pass_header*]    - Array of server headers to pass
#   [*fastcgi*]              - location of fastcgi (host:port)
#   [*fastcgi_param*]        - Set additional custom fastcgi_params
#   [*fastcgi_params*]       - optional alternative fastcgi_params file to use
#   [*fastcgi_script*]       - optional SCRIPT_FILE parameter
#   [*fastcgi_split_path*]   - Allows settings of fastcgi_split_path_info so
#     that you can split the script_name and path_info via regex
#   [*uwsgi*]              - location of uwsgi (host:port)
#   [*uwsgi_param*]        - Set additional custom uwsgi_params
#   [*uwsgi_params*]       - optional alternative uwsgi_params file to use
#   [*uwsgi_read_timeout*]   - optional value for uwsgi_read_timeout
#   [*ssl*]                  - Indicates whether to setup SSL bindings for
#     this location.
#   [*ssl_only*]             - Required if the SSL and normal server have the
#     same port.
#   [*location_alias*]       - Path to be used as basis for serving requests
#     for this location
#   [*stub_status*]          - If true it will point configure module
#     stub_status to provide nginx stats on location
#   [*raw_prepend*]          - A single string, or an array of strings to
#     prepend to the location directive (after custom_cfg directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*raw_append*]           - A single string, or an array of strings to
#     append to the location directive (after custom_cfg directives). NOTE:
#     YOU are responsible for a semicolon on each line that requires one.
#   [*location_custom_cfg*]  - Expects a hash with custom directives, cannot
#     be used with other location types (proxy, fastcgi, root, or stub_status)
#   [*location_cfg_prepend*] - Expects a hash with extra directives to put
#     before anything else inside location (used with all other types except
#     custom_cfg)
#   [*location_custom_cfg_prepend*]   - Expects a array with extra directives
#     to put before anything else inside location (used with all other types
#     except custom_cfg). Used for logical structures such as if.
#   [*location_custom_cfg_append*]    - Expects a array with extra directives
#     to put after anything else inside location (used with all other types
#     except custom_cfg). Used for logical structures such as if.
#   [*location_cfg_append*]   - Expects a hash with extra directives to put
#     after everything else inside location (used with all other types except
#     custom_cfg)
#   [*include*]               - An array of files to include for this location
#   [*try_files*]             - An array of file locations to try
#   [*option*]                - Reserved for future use
#   [*proxy_cache*]           - This directive sets name of zone for caching.
#     The same zone can be used in multiple places.
#   [*proxy_cache_key*]       - Override the default proxy_cache_key of
#     $scheme$proxy_host$request_uri
#   [*proxy_cache_use_stale*] - Override the default proxy_cache_use_stale value
#     of off.
#   [*proxy_cache_valid*]     - This directive sets the time for caching
#     different replies.
#   [*proxy_method*]          - If defined, overrides the HTTP method of the
#     request to be passed to the backend.
#   [*proxy_http_version*]    - Sets the proxy http version
#   [*proxy_set_body*]        - If defined, sets the body passed to the backend.
#   [*proxy_buffering*]       - If defined, sets the proxy_buffering to the passed
#     value.
#   [*auth_basic*]            - This directive includes testing name and password
#     with HTTP Basic Authentication.
#   [*auth_basic_user_file*]  - This directive sets the htpasswd filename for
#     the authentication realm.
#   [*auth_request*]          - This allows you to specify a custom auth endpoint
#   [*priority*]              - Location priority. Default: 500. User priority
#     401-499, 501-599. If the priority is higher than the default priority,
#     the location will be defined after root, or before root.
#   [*mp4*]             - Indicates whether or not this loation can be
#     used for mp4 streaming. Default: false
#   [*flv*]             - Indicates whether or not this loation can be
#     used for flv streaming. Default: false
#   [*expires*]         - Setup expires time for locations content
#
#
# Actions:
#
# Requires:
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

define nginx::resource::location (
  $ensure                      = present,
  $internal                    = false,
  $location                    = $name,
  $server                      = undef,
  $www_root                    = undef,
  $autoindex                   = undef,
  $index_files                 = [
    'index.html',
    'index.htm',
    'index.php'],
  $proxy                       = undef,
  $proxy_redirect              = $::nginx::proxy_redirect,
  $proxy_read_timeout          = $::nginx::proxy_read_timeout,
  $proxy_connect_timeout       = $::nginx::proxy_connect_timeout,
  $proxy_set_header            = $::nginx::proxy_set_header,
  $proxy_hide_header           = $::nginx::proxy_hide_header,
  $proxy_pass_header           = $::nginx::proxy_pass_header,
  $fastcgi                     = undef,
  $fastcgi_index               = undef,
  $fastcgi_param               = undef,
  $fastcgi_params              = "${::nginx::conf_dir}/fastcgi_params",
  $fastcgi_script              = undef,
  $fastcgi_split_path          = undef,
  $uwsgi                       = undef,
  $uwsgi_param                 = undef,
  $uwsgi_params                = "${nginx::config::conf_dir}/uwsgi_params",
  $uwsgi_read_timeout          = undef,
  $ssl                         = false,
  $ssl_only                    = false,
  $location_alias              = undef,
  $location_satisfy            = undef,
  $location_allow              = undef,
  $location_deny               = undef,
  $option                      = undef,
  $stub_status                 = undef,
  $raw_prepend                 = undef,
  $raw_append                  = undef,
  $location_custom_cfg         = undef,
  $location_cfg_prepend        = undef,
  $location_cfg_append         = undef,
  $location_custom_cfg_prepend = undef,
  $location_custom_cfg_append  = undef,
  $include                     = undef,
  $try_files                   = undef,
  $proxy_cache                 = false,
  $proxy_cache_key             = undef,
  $proxy_cache_use_stale       = undef,
  $proxy_cache_valid           = false,
  $proxy_method                = undef,
  $proxy_http_version          = undef,
  $proxy_set_body              = undef,
  $proxy_buffering             = undef,
  $auth_basic                  = undef,
  $auth_basic_user_file        = undef,
  $auth_request                = undef,
  $rewrite_rules               = [],
  $priority                    = 500,
  $mp4                         = false,
  $flv                         = false,
  $expires                     = undef,
) {

  $root_group = $::nginx::root_group

  File {
    owner  => 'root',
    group  => $root_group,
    mode   => '0644',
    notify => Class['::nginx::service'],
  }

  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  validate_string($location)
  if ($server != undef) {
    validate_string($server)
  }
  if ($www_root != undef) {
    validate_string($www_root)
  }
  if ($autoindex != undef) {
    validate_string($autoindex)
  }
  if ($index_files != undef) {
    validate_array($index_files)
  }
  if ($proxy != undef) {
    validate_string($proxy)
  }
  if ($proxy_redirect != undef) {
    validate_string($proxy_redirect)
  }
  validate_string($proxy_read_timeout)
  validate_string($proxy_connect_timeout)
  validate_array($proxy_set_header)
  validate_array($proxy_hide_header)
  validate_array($proxy_pass_header)
  if ($fastcgi != undef) {
    validate_string($fastcgi)
  }
  if ($fastcgi_param != undef) {
    validate_hash($fastcgi_param)
  }
  validate_string($fastcgi_params)
  if ($fastcgi_script != undef) {
    validate_string($fastcgi_script)
  }
  if ($fastcgi_split_path != undef) {
    validate_string($fastcgi_split_path)
  }
  if ($fastcgi_index != undef) {
    validate_string($fastcgi_index)
  }
  if ($uwsgi != undef) {
    validate_string($uwsgi)
  }
  if ($uwsgi_param != undef) {
    validate_hash($uwsgi_param)
  }
  validate_string($uwsgi_params)
  if ($uwsgi_read_timeout != undef) {
    validate_string($uwsgi_read_timeout)
  }

  validate_bool($internal)

  validate_bool($ssl)
  validate_bool($ssl_only)
  if ($location_alias != undef) {
    validate_string($location_alias)
  }
  if ($location_satisfy != undef) {
    validate_re($location_satisfy, '^(any|all)$',
    "${$location_satisfy} is not supported for location_satisfy. Allowed values are 'any' and 'all'.")
  }
  if ($location_allow != undef) {
    validate_array($location_allow)
  }
  if ($location_deny != undef) {
    validate_array($location_deny)
  }
  if ($option != undef) {
    warning('The $option parameter has no effect and is deprecated.')
  }
  if ($stub_status != undef) {
    validate_bool($stub_status)
  }
  if ($raw_prepend != undef) {
    if (is_array($raw_prepend)) {
      validate_array($raw_prepend)
    } else {
      validate_string($raw_prepend)
    }
  }
  if ($raw_append != undef) {
    if (is_array($raw_append)) {
      validate_array($raw_append)
    } else {
      validate_string($raw_append)
    }
  }
  if ($location_custom_cfg != undef) {
    validate_hash($location_custom_cfg)
  }
  if ($location_cfg_prepend != undef) {
    validate_hash($location_cfg_prepend)
  }
  if ($location_cfg_append != undef) {
    validate_hash($location_cfg_append)
  }
  if ($include != undef) {
    validate_array($include)
  }
  if ($try_files != undef) {
    validate_array($try_files)
  }
  if ($proxy_cache != false) {
    validate_string($proxy_cache)
  }
  if ($proxy_cache_key != undef) {
    validate_string($proxy_cache_key)
  }
  if ($proxy_cache_use_stale != undef) {
    validate_string($proxy_cache_use_stale)
  }
  if ($proxy_cache_valid != false) {
    if !(is_array($proxy_cache_valid) or is_string($proxy_cache_valid)) {
      fail('$proxy_cache_valid must be a string or an array or false.')
    }
  }
  if ($proxy_method != undef) {
    validate_string($proxy_method)
  }
  if ($proxy_http_version != undef) {
    validate_string($proxy_http_version)
  }
  if ($proxy_set_body != undef) {
    validate_string($proxy_set_body)
  }
  if ($proxy_buffering != undef) {
    validate_re($proxy_buffering, '^(on|off)$')
  }
  if ($auth_basic != undef) {
    validate_string($auth_basic)
  }
  if ($auth_basic_user_file != undef) {
    validate_string($auth_basic_user_file)
  }
  if ($auth_request != undef) {
    validate_string($auth_request)
  }
  if !is_integer($priority) {
    fail('$priority must be an integer.')
  }
  validate_array($rewrite_rules)
  if (($priority + 0) < 401) or (($priority + 0) > 599) {
    fail('$priority must be in the range 401-599.')
  }
  if ($expires != undef) {
    validate_string($expires)
  }

  # # Shared Variables
  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => file,
  }

  ## Check for various error conditions
  if ($server == undef) {
    fail('Cannot create a location reference without attaching to a virtual host')
  }
  if !($www_root or $proxy or $location_alias or $stub_status or $fastcgi or $uwsgi or $location_custom_cfg or $internal or $try_files or $location_allow or $location_deny) {
    fail("Cannot create a location reference without a www_root, proxy, location_alias, stub_status, fastcgi, uwsgi, location_custom_cfg, internal, try_files, location_allow, or location_deny defined in ${server}:${title}")
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
  if $::nginx::confd_only {
    $server_dir = "${::nginx::conf_dir}/conf.d"
  } else {
    $server_dir = "${::nginx::conf_dir}/sites-available"
  }

  $config_file = "${server_dir}/${server_sanitized}.conf"

  $location_sanitized_tmp = regsubst($location, '\/', '_', 'G')
  $location_sanitized = regsubst($location_sanitized_tmp, '\\\\', '_', 'G')

  if $ensure == present and $fastcgi != undef and !defined(File[$fastcgi_params]) {
    file { $fastcgi_params:
      ensure  => present,
      mode    => '0770',
      content => template('nginx/server/fastcgi_params.erb'),
    }
  }

  if $ensure == present and $uwsgi != undef and !defined(File[$uwsgi_params]) {
    file { $uwsgi_params:
      ensure  => present,
      mode    => '0770',
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
