# This definition creates a reusable config snippet that can be included by other resources
#
# @param ensure Enables or disables the specified snippet
# @param owner Defines owner of the .conf file
# @param group Defines group of the .conf file
# @param mode Defines mode of the .conf file
# @param raw_content Raw content that will be inserted into the snipped as-is

define nginx::resource::snippet (
  String[1] $raw_content,
  Enum['absent', 'present'] $ensure = 'present',
  String $owner                     = $nginx::global_owner,
  String $group                     = $nginx::global_group,
  Stdlib::Filemode $mode            = $nginx::global_mode,
) {
  if ! defined(Class['nginx']) {
    fail('You must include the nginx base class before using any defined resources')
  }

  $name_sanitized = regsubst($name, ' ', '_', 'G')
  $config_file = "${nginx::snippets_dir}/${name_sanitized}.conf"

  concat { $config_file:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    notify  => Class['nginx::service'],
    require => File[$nginx::snippets_dir],
  }

  concat::fragment { "snippet-${name_sanitized}-header":
    target  => $config_file,
    content => epp("${module_name}/snippet/snippet_header.epp", { 'raw_content' => $raw_content }),
    order   => '001',
  }
}
