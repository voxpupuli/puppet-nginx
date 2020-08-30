# @summary Create an upstream member inside the upstream block.
#
# Export this resource in all upstream member servers and collect them on the
# NGINX server. Exporting resources requires storeconfigs on the Puppetserver
# to export and collect resources
#
# @param upstream
#   The name of the upstream resource
# @param ensure
#   Enables or disables the specified member
# @param context
#   Set the type of this upstream
# @param server
#   Hostname or IP of the upstream member server
# @param port
#   Port of the listening service on the upstream member
# @param weight
#   Set the weight for this upstream member
# @param max_conns
#   Set the max_conns for this upstream member
# @param max_fails
#   Set the max_fails for this upstream member
# @param fail_timeout
#   Set the fail_timeout for this upstream member
# @param backup
#   Activate backup for this upstream member
# @param resolve
#   Activate resolve for this upstream member
# @param route
#   Set the route for this upstream member
# @param service
#   Set the service for this upstream member
# @param slow_start
#   Set the slow_start for this upstream member
# @param state
#   Set the state for this upstream member
# @param params_prepend
#   prepend a parameter for this upstream member
# @param params_append
#   append a paremeter for this upstream member
# @param comment
#   Add a comment for this upstream member
#
# @example Exporting the resource on a upstream member server:
#   @@nginx::resource::upstream::member { $trusted['certname']:
#     ensure   => present,
#     upstream => 'proxypass',
#     server   => $facts['networking']['ip'],
#     port     => 3000,
#   }
#
# @example Collecting the resource on the NGINX server:
#   nginx::resource::upstream { 'proxypass':
#     ensure => present,
#   }
#
define nginx::resource::upstream::member (
  String[1]                               $upstream,
  Enum['present', 'absent']               $ensure           = 'present',
  Enum['http', 'stream']                  $context          = 'http',
  Optional[Nginx::UpstreamMemberServer]   $server           = $name,
  Stdlib::Port                            $port             = 80,
  Optional[Integer[1]]                    $weight           = undef,
  Optional[Integer[1]]                    $max_conns        = undef,
  Optional[Integer[0]]                    $max_fails        = undef,
  Optional[Nginx::Time]                   $fail_timeout     = undef,
  Boolean                                 $backup           = false,
  Boolean                                 $resolve          = false,
  Optional[String[1]]                     $route            = undef,
  Optional[String[1]]                     $service          = undef,
  Optional[Nginx::Time]                   $slow_start       = undef,
  Optional[Enum['drain','down']]          $state            = undef,
  Optional[String[1]]                     $params_prepend   = undef,
  Optional[String[1]]                     $params_append    = undef,
  Optional[String[1]]                     $comment          = undef,
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  $conf_dir = $context ? {
    'stream' => "${nginx::config::conf_dir}/conf.stream.d",
    default  => "${nginx::config::conf_dir}/conf.d",
  }

  $_server = $server ? {
    Pattern[/^unix:\/([^\/\0]+\/*)*$/] => $server,
    Stdlib::IP::Address::V6            => "[${server}]:${port}", #lint:ignore:unquoted_string_in_selector
    default                            => "${server}:${port}",
  }

  concat::fragment { "${upstream}_upstream_member_${name}":
    target  => "${conf_dir}/${upstream}-upstream.conf",
    order   => 40,
    content => epp('nginx/upstream/upstream_member.epp', {
        server         => $_server,
        backup         => $backup,
        comment        => $comment,
        fail_timeout   => $fail_timeout,
        max_conns      => $max_conns,
        max_fails      => $max_fails,
        params_append  => $params_append,
        params_prepend => $params_prepend,
        resolve        => $resolve,
        route          => $route,
        service        => $service,
        slow_start     => $slow_start,
        state          => $state,
        weight         => $weight,
    }),
  }
}
