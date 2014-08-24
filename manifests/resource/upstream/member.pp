# Define: nginx::resources::upstream::member
# Legacy resource, will be deprecated soon.
define nginx::resource::upstream::member (
  $upstream               = undef,
  $server                 = undef,
  $port                   = '80',
  $upstream_fail_timeout  = '10s',
) {

  notify { '**WARNING**: Usage of the nginx::resource::upstream::member defined type will be deprecated soon. Please use nginx::upstream.': }

  nginx::upstream { $name:
    upstream              => $upstream,
    server                => $server,
    port                  => $port,
    upstream_fail_timeout => $upstream_fail_timeout,
  }
}
