# Class: nginx::package::openbsd
#
# Manage the nginx package on OpenBSD
class nginx::package::openbsd (
    $package_name   = 'nginx',
    $package_ensure = 'present'
) {

  package { $package_name:
    ensure  => $package_ensure,
  }
}
