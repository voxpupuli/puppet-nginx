# define: nginx::resource::upstream
#
# Legacy defined type. Will be removed soon.
define nginx::resource::upstream (
  $members               = undef,
  $ensure                = 'present',
  $upstream_cfg_prepend  = undef,
  $upstream_fail_timeout = '10s',
) {
  notify { '**WARNING**: Usage of the nginx::resource::upstream defined type will be deprecated soon. Please use nginx::upstream.': }

  nginx::upstream { $name:
    ensure                => $ensure,
    members               => $members,
    upstream_cfg_prepend  => $upstream_cfg_prepend,
    upstream_fail_timeout => $upstream_fail_timeout,
  }
}
