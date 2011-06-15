# define: nginx::resource::location
#
# This definition creates a new location entry within a virtual host
#
# Parameters:
#   [*ensure*]      - Enables or disables the specified location (present|absent)
#   [*vhost*]       - Defines the default vHost for this location entry to include with
#   [*location*]    - Specifies the URI associated with this location entry
#   [*www_root*]    - Specifies the location on disk for files to be read from. Cannot be set in conjunction with $proxy
#   [*index_files*] - Default index files for NGINX to read when traversing a directory
#   [*proxy*]       - Proxy server(s) for a location to connect to. Accepts a single value, can be used in conjunction
#                     with nginx::resource::upstream
#   [*ssl*]         - Indicates whether to setup SSL bindings for this location.
#   [*option*]      - Reserved for future use
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
#    vhost    => 'test2.local',
#  }
define nginx::resource::location(
  $ensure      = present,
  $vhost       = undef,
  $www_root    = undef,
  $index_files = ['index.html', 'index.htm', 'index.php'],
  $proxy       = undef,
  $ssl         = false,
  $option      = undef,
  $location
) {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class['nginx::service'],
  }

  ## Shared Variables
  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => file,
  }

  # Use proxy template if $proxy is defined, otherwise use directory template.
  if ($proxy != undef) {
    $content_real = template('nginx/vhost/vhost_location_proxy.erb')
  } else {
    $content_real = template('nginx/vhost/vhost_location_directory.erb')
  }

  ## Check for various error condtiions
  if ($vhost == undef) {
    fail('Cannot create a location reference without attaching to a virtual host')
  }
  if (($www_root == undef) and ($proxy == undef)) {
    fail('Cannot create a location reference without a www_root or proxy defined')
  }
  if (($www_root != undef) and ($proxy != undef)) {
    fail('Cannot define both directory and proxy in a virtual host')
  }

  ## Create stubs for vHost File Fragment Pattern
  file {"${nginx::config::nx_temp_dir}/nginx.d/${vhost}-500-${name}":
    ensure  => $ensure_real,
    content => $content_real,
  }

  ## Only create SSL Specific locations if $ssl is true.
  if ($ssl == 'true') {
    file {"${nginx::config::nx_temp_dir}/nginx.d/${vhost}-800-${name}-ssl":
      ensure  => $ensure_real,
      content => $content_real,
    }
  }
}
