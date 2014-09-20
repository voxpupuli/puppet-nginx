# See README.md for usage information
define nginx::resource::geo (
  $networks,
  $default         = undef,
  $ensure          = 'present',
  $ranges          = false,
  $address         = undef,
  $delete          = undef,
  $proxies         = undef,
  $proxy_recursive = undef
) {

  validate_hash($networks)
  validate_bool($ranges)
  validate_re($ensure, '^(present|absent)$',
    "Invalid ensure value '${ensure}'. Expected 'present' or 'absent'")
  if ($default != undef) { validate_string($default) }
  if ($address != undef) { validate_string($address) }
  if ($delete != undef) { validate_string($delete) }
  if ($proxies != undef) { validate_array($proxies) }
  if ($proxy_recursive != undef) { validate_bool($proxy_recursive) }

  include nginx::params
  $root_group = $nginx::params::root_group

  $ensure_real = $ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  File {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  file { "${nginx::config::conf_dir}/conf.d/${name}-geo.conf":
    ensure  => $ensure_real,
    content => template('nginx/conf.d/geo.erb'),
    notify  => Class['nginx::service'],
  }
}
