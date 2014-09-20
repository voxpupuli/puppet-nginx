# See README.md for usage information
define nginx::resource::map (
  $string,
  $mappings,
  $default    = undef,
  $ensure     = 'present',
  $hostnames  = false
) {
  validate_string($string)
  validate_re($string, '^.{2,}$',
    "Invalid string value [${string}]. Expected a minimum of 2 characters.")
  validate_hash($mappings)
  validate_bool($hostnames)
  validate_re($ensure, '^(present|absent)$',
    "Invalid ensure value '${ensure}'. Expected 'present' or 'absent'")
  if ($default != undef) { validate_string($default) }

  include nginx::params
  $root_group = $nginx::params::root_group

  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => 'file',
  }

  File {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  file { "${nginx::config::conf_dir}/conf.d/${name}-map.conf":
    ensure  => $ensure_real,
    content => template('nginx/conf.d/map.erb'),
    notify  => Class['nginx::service'],
  }
}
