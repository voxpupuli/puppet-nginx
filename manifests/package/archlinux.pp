class nginx::package::archlinux(
    $package_name   = 'nginx',
    $package_ensure = 'present'
  ) {

  package { $package_name:
    ensure  => $package_ensure,
  }

}
