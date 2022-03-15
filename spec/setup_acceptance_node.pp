if $facts['os']['name'] == 'Ubuntu' {
  # Facter < 4 needs lsb-release for os.distro.codename
  if versioncmp($facts['facterversion'], '4.0.0') <= 0 {
    package { 'lsb-release':
      ensure => installed,
    }
  }
}
