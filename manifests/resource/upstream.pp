# See README.md for usage information
define nginx::resource::upstream (
  $members = undef,
  $ensure = 'present',
  $upstream_cfg_prepend = undef,
  $upstream_fail_timeout = '10s',
) {

  if $members != undef {
    validate_array($members)
  }
  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  if ($upstream_cfg_prepend != undef) {
    validate_hash($upstream_cfg_prepend)
  }

  include nginx::params
  $root_group = $nginx::params::root_group

  $ensure_real = $ensure ? {
    'absent' => absent,
    default  => present,
  }

  Concat {
    owner => 'root',
    group => $root_group,
    mode  => '0644',
  }

  concat { "${nginx::config::conf_dir}/conf.d/${name}-upstream.conf":
    ensure => $ensure_real,
    notify => Class['nginx::service'],
  }

  # Uses: $name, $upstream_cfg_prepend
  concat::fragment { "${name}_upstream_header":
    target  => "${nginx::config::conf_dir}/conf.d/${name}-upstream.conf",
    order   => '10',
    content => template('nginx/conf.d/upstream_header.erb'),
  }

  if $members != undef {
    # Uses: $members, $upstream_fail_timeout
    concat::fragment { "${name}_upstream_members":
      target  => "${nginx::config::conf_dir}/conf.d/${name}-upstream.conf",
      order   => '50',
      content => template('nginx/conf.d/upstream_members.erb'),
    }
  } else {
    # Collect exported members:
    Nginx::Resource::Upstream::Member <<| upstream == $name |>>
  }

  concat::fragment { "${name}_upstream_footer":
    target  => "${nginx::config::conf_dir}/conf.d/${name}-upstream.conf",
    order   => '90',
    content => "}\n",
  }
}
