class nginx::package::suse (
  $package_name = 'nginx'
) {

  if $caller_module_name != $module_name {
    warning("${name} is deprecated as a public API of the ${module_name} module and should no longer be directly included in the manifest.")
  }

  package { $package_name:
    ensure => $nginx::package_ensure,
  }
}
