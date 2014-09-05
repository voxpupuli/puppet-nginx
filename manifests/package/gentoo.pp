# Class: nginx::package::gentoo
#
# Manage the nginx package on Gentoo
class nginx::package::gentoo(
    $package_name   = 'www-servers/nginx',
    $package_ensure = 'present'
  ) {

  package { $package_name:
    ensure  => $package_ensure,
  }

}
