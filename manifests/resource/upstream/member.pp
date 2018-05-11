# Define: nginx::resources::upstream::member
#
# Creates an upstream member inside the upstream block. Export this resource
# in all upstream member servers and collect them on the NGINX server.
#
#
# Requirements:
#   Requires storeconfigs on the Puppet Master to export and collect resources
#
#
# Parameters:
#   [*ensure*]                  - Enables or disables the specified member (present|absent)
#   [*upstream*]                - The name of the upstream resource
#   [*server*]                  - Hostname or IP of the upstream member server
#   [*port*]                    - Port of the listening service on the upstream member
#   [*upstream_fail_timeout*]   - Set the fail_timeout for the upstream. Default is 10 seconds
#
#
# Examples:
#
#   Exporting the resource on a upstream member server:
#
#   @@nginx::resource::upstream::member { $trusted['certname']:
#     ensure    => present,
#     upstream  => 'proxypass',
#     server    => $facts['networking']['ip'],
#     port      => 3000,
#   }
#
#
#   Collecting the resource on the NGINX server:
#
#   nginx::resource::upstream { 'proxypass':
#     ensure    => present,
#   }
#
define nginx::resource::upstream::member (
  $upstream,
  $server,
  Enum['present', 'absent'] $ensure = 'present',
  Integer $port                     = 80,
  $upstream_fail_timeout  = '10s',
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  # Uses: $server, $port, $upstream_fail_timeout
  concat::fragment { "${upstream}_upstream_member_${name}":
    target  => "${nginx::conf_dir}/conf.d/${upstream}-upstream.conf",
    order   => 40,
    content => template('nginx/upstream/upstream_member.erb'),
  }
}
