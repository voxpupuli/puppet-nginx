# Define: nginx::resources::upstream::member
#
# This is a legacy resource that will be deprecated in v1.0.0
#
# Please add any additions to nginx::upstream::member
define nginx::resource::upstream::member (
  $upstream              = undef,
  $server                = undef,
  $port                  = undef,
  $upstream_fail_timeout = undef,
) {
  nginx::notice::resources { $name: }

  nginx::upstream::member { $name:
    upstream              => $upstream,
    server                => $server,
    port                  => $port,
    upstream_fail_timeout => $upstream_fail_timeout,
  }
}
