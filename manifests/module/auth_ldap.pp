# define: nginx::module::auth_ldap
#
# This definition creates a new location entry within a virtual host
#
define nginx::module::auth_ldap (
  $server                = 'dc01',
  $url                   = 'ldap://dc01.example.com:389/OU=Users,DC=example,DC=com?sAMAccountName?sub?(objectClass=person)',
  $binddn                = undef,
  $binddn_passwd         = undef,
  $group_attribute       = 'member',
  $group_attribute_is_dn = 'on',
  $satisfy               = 'any',
  $require_group_dn      = [],
  $require_user_dn       = [],
) {

  include nginx

  $_root_group      = $::nginx::config::root_group
  $_auth_ldap_conf  = "${::nginx::config::conf_dir}/conf.d/${server}.conf"

  concat { $_auth_ldap_conf:
    owner  => 'root',
    group  => $_root_group,
    mode   => '0644',
    path   => $_auth_ldap_conf,
    notify => Class['::nginx::service'],
  }
  concat::fragment { "nginx auth_ldap module: ${server}":
    target  => $_auth_ldap_conf,
    content => template('nginx/module/auth_ldap.erb'),
  }

}
