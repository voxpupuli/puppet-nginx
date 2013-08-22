define nginx::resource::config ($ensure = 'present', $config) {
  include nginx::params
  validate_hash($config)

  file { "${nginx::params::nx_conf_dir}/conf.d/${name}.conf":
    content => template('nginx/conf.d/config.erb'),
    ensure  => $ensure,
    notify  => Service['nginx'],
  }
}
