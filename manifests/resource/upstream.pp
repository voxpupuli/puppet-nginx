# define: nginx::resource::upstream
#
# This definition creates a new upstream proxy entry for NGINX
#
# Parameters:
#   [*ensure*]                - Enables or disables the specified location (present|absent)
#   [*context*]               - Set the type of this upstream (http|stream).
#   [*members*]               - Hash of member URIs for NGINX to connect to. Must follow valid NGINX syntax.
#                               If omitted, individual members should be defined with nginx::resource::upstream::member
#   [*members_tag*]           - Restrict collecting the exported members for this upstream with a tag.
#   [*member_defaults*]       - Specify default settings added to each member of this upstream.
#   [*hash*]                  - Activate the hash load balancing method (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#hash).
#   [*ip_hash*]               - Activate ip_hash for this upstream (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#ip_hash).
#   [*keepalive*]             - Set the maximum number of idle keepalive connections (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#keepalive).
#   [*keepalive_requests*]    - Sets the maximum number of requests that can be served through one keepalive connection (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#keepalive_requests).
#   [*keepalive_timeout*]     - Sets a timeout during which an idle keepalive connection to an upstream server will stay open (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#keepalive_timeout).
#   [*least_conn*]            - Activate the least_conn load balancing method (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#least_conn).
#   [*least_time*]            - Activate the least_time load balancing method (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#least_time).
#   [*ntlm*]                  - Allow NTLM authentication (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#ntlm).
#   [*queue_max*]             - Set the maximum number of queued requests (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#queue).
#   [*queue_timeout*]         - Set the timeout for the queue (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#queue).
#   [*random*]                - Activate the random load balancing method (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#random).
#   [*statefile*]             - Specifies a file that keeps the state of the dynamically configurable group (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#state).
#   [*sticky*]                - Enables session affinity (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#sticky).
#   [*zone*]                  - Defines the name and optional the size of the shared memory zone (https://nginx.org/en/docs/http/ngx_http_upstream_module.html#zone).
#   [*cfg_append*]            - Hash of custom directives to put after other directives in upstream
#   [*cfg_prepend*]           - It expects a hash with custom directives to put before anything else inside upstream
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::upstream { 'proxypass':
#    ensure  => present,
#    members => {
#      'localhost:3001' => {
#        server => 'localhost',
#        port   => 3001,
#      },
#      'localhost:3002' => {
#        server => 'localhost',
#        port   => 3002,
#      },
#      'localhost:3003' => {
#        server => 'localhost',
#        port   => 3003,
#      },
#    },
#  }
#
#  Custom config example to use ip_hash, and 20 keepalive connections
#  create a hash with any extra custom config you want.
#  nginx::resource::upstream { 'proxypass':
#    ensure    => present,
#    members   => {
#      'localhost:3001' => {
#        server => 'localhost',
#        port   => 3001,
#      },
#      'localhost:3002' => {
#        server => 'localhost',
#        port   => 3002,
#      },
#      'localhost:3003' => {
#        server => 'localhost',
#        port   => 3003,
#      },
#    },
#    ip_hash   => true,
#    keepalive => 20,
#  }
#
define nginx::resource::upstream (
  Enum['present', 'absent']           $ensure                 = 'present',
  Enum['http', 'stream']              $context                = 'http',
  Nginx::UpstreamMembers              $members                = {},
  Optional[String[1]]                 $members_tag            = undef,
  Nginx::UpstreamMemberDefaults       $member_defaults        = {},
  Optional[String[1]]                 $hash                   = undef,
  Boolean                             $ip_hash                = false,
  Optional[Integer[1]]                $keepalive              = undef,
  Optional[Integer[1]]                $keepalive_requests     = undef,
  Optional[Nginx::Time]               $keepalive_timeout      = undef,
  Boolean                             $least_conn             = false,
  Optional[Nginx::UpstreamLeastTime]  $least_time             = undef,
  Boolean                             $ntlm                   = false,
  Optional[Integer]                   $queue_max              = undef,
  Optional[Nginx::Time]               $queue_timeout          = undef,
  Optional[String[1]]                 $random                 = undef,
  Optional[Stdlib::Unixpath]          $statefile              = undef,
  Optional[Nginx::UpstreamSticky]     $sticky                 = undef,
  Optional[Nginx::UpstreamZone]       $zone                   = undef,
  Nginx::UpstreamCustomParameters     $cfg_append             = {},
  Nginx::UpstreamCustomParameters     $cfg_prepend            = {},
) {

  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  if $least_time {
    if $context == 'http' and ! ($least_time =~ Nginx::UpstreamLeastTimeHttp) {
      fail('The parameter "least_time" does not match the datatype "Nginx::UpstreamLeastTimeHttp"')
    }
    if $context == 'stream' and ! ($least_time =~ Nginx::UpstreamLeastTimeStream) {
      fail('The parameter "least_time" does not match the datatype "Nginx::UpstreamLeastTimeStream"')
    }
  }

  $conf_dir = $context ? {
    'stream' => "${nginx::config::conf_dir}/conf.stream.d",
    default  => "${nginx::config::conf_dir}/conf.d",
  }

  Concat {
    owner => 'root',
    group => $nginx::root_group,
    mode  => '0644',
  }

  concat { "${conf_dir}/${name}-upstream.conf":
    ensure  => $ensure,
    notify  => Class['::nginx::service'],
    require => File[$conf_dir],
  }

  concat::fragment { "${name}_upstream_header":
    target  => "${conf_dir}/${name}-upstream.conf",
    order   => '10',
    content => epp('nginx/upstream/upstream_header.epp', {
      cfg_prepend => $cfg_prepend,
      name        => $name,
    }),
  }

  if ! empty($members) {
    $members.each |$member,$values| {
      $member_values = merge($member_defaults,$values,{'upstream' => $name,'context' => $context})

      if $context == 'stream' and $member_values['route'] {
        fail('The parameter "route" is not available for upstreams with context "stream"')
      }
      if $context == 'stream' and $member_values['state'] and $member_values['state'] == 'drain' {
        fail('The state "drain" is not available for upstreams with context "stream"')
      }

      nginx::resource::upstream::member { $member:
        * => $member_values,
      }
    }
  } else {
    # Collect exported members:
    if $members_tag {
      Nginx::Resource::Upstream::Member <<| upstream == $name and tag == $members_tag |>>
    } else {
      Nginx::Resource::Upstream::Member <<| upstream == $name |>>
    }
  }

  concat::fragment { "${name}_upstream_footer":
    target  => "${conf_dir}/${name}-upstream.conf",
    order   => '90',
    content => epp('nginx/upstream/upstream_footer.epp', {
      cfg_append         => $cfg_append,
      hash               => $hash,
      ip_hash            => $ip_hash,
      keepalive          => $keepalive,
      keepalive_requests => $keepalive_requests,
      keepalive_timeout  => $keepalive_timeout,
      least_conn         => $least_conn,
      least_time         => $least_time,
      ntlm               => $ntlm,
      queue_max          => $queue_max,
      queue_timeout      => $queue_timeout,
      random             => $random,
      statefile          => $statefile,
      sticky             => $sticky,
      zone               => $zone,
    }),
  }
}
