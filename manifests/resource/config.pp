define nginx::resource::config (
  $ensure   = 'present',
  $config,
  $filetype = 'conf') {
  include nginx::params
  validate_hash($config)

  file { "${nginx::params::nx_conf_dir}/conf.d/${name}.${filetype}":
    content => template('nginx/conf.d/config.erb'),
    ensure  => $ensure,
    notify  => Service['nginx'],
  }
}
