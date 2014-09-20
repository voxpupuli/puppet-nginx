class nginx::package::solaris(
    $package_name   = undef,
    $package_source = '',
    $package_ensure = 'present'
  ){
  package { $package_name:
    ensure => $package_ensure,
    source => $package_source
  }
}
