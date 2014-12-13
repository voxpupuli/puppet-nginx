# define: nginx::resource::upstream
#
# This is a legacy resource that will be deprecated in v1.0.0
#
# Please add any additions to nginx::geo
define nginx::resource::upstream (
  $members               = undef,
  $ensure                = undef,
  $upstream_cfg_prepend  = undef,
  $upstream_fail_timeout = undef,
) {
  nginx::notice::resources { $name: }

  nginx::upstream { $name:
    members               => $members,
    ensure                => $ensure,
    upstream_cfg_prepend  => $upstream_cfg_prepend,
    upstream_fail_timeout => $upstream_fail_timeout,
  }
}
