# @summary Manage NGINX package installation on RedHat based systems
# @api private
class nginx::package::redhat {
  $package_name             = $nginx::package_name
  $package_source           = $nginx::package_source
  $package_ensure           = $nginx::package_ensure
  $package_flavor           = $nginx::package_flavor
  $passenger_package_ensure = $nginx::passenger_package_ensure
  $passenger_package_name   = $nginx::passenger_package_name
  $manage_repo              = $nginx::manage_repo
  $purge_passenger_repo     = $nginx::purge_passenger_repo

  #Install the CentOS-specific packages on that OS, otherwise assume it's a RHEL
  #clone and provide the Red Hat-specific package. This comes into play when not
  #on RHEL or CentOS and $manage_repo is set manually to 'true'.
  $_os = $facts['os']['name'] ? {
    'centos'         => 'centos',
    'VirtuozzoLinux' => 'centos',
    'OracleLinux'    => 'centos',
    default          => 'rhel'
  }

  if $manage_repo {
    case $package_source {
      'nginx', 'nginx-stable': {
        yumrepo { 'nginx-release':
          baseurl         => "https://nginx.org/packages/${_os}/${facts['os']['release']['major']}/\$basearch/",
          descr           => 'nginx repo',
          enabled         => '1',
          gpgcheck        => '1',
          priority        => '1',
          gpgkey          => 'https://nginx.org/keys/nginx_signing.key',
          before          => Package['nginx'],
          module_hotfixes => '1',
        }

        if $purge_passenger_repo {
          yumrepo { 'passenger':
            ensure => absent,
            before => Package['nginx'],
          }
        }
      }
      'nginx-mainline': {
        yumrepo { 'nginx-release':
          baseurl         => "https://nginx.org/packages/mainline/${_os}/${facts['os']['release']['major']}/\$basearch/",
          descr           => 'nginx repo',
          enabled         => '1',
          gpgcheck        => '1',
          priority        => '1',
          gpgkey          => 'https://nginx.org/keys/nginx_signing.key',
          before          => Package['nginx'],
          module_hotfixes => '1',
        }

        if $purge_passenger_repo {
          yumrepo { 'passenger':
            ensure => absent,
            before => Package['nginx'],
          }
        }
      }
      'passenger': {
        yumrepo { 'passenger':
          baseurl         => "https://oss-binaries.phusionpassenger.com/yum/passenger/el/${facts['os']['release']['major']}/\$basearch",
          descr           => 'passenger repo',
          enabled         => '1',
          gpgcheck        => '0',
          repo_gpgcheck   => '1',
          priority        => '1',
          gpgkey          => 'https://oss-binaries.phusionpassenger.com/auto-software-signing-gpg-key.txt',
          before          => Package['nginx'],
          module_hotfixes => '1',
        }

        yumrepo { 'nginx-release':
          ensure => absent,
          before => Package['nginx'],
        }

        package { $passenger_package_name:
          ensure  => $passenger_package_ensure,
          require => Yumrepo['passenger'],
        }
      }
      default: {
        fail("\$package_source must be 'nginx-stable', 'nginx-mainline', or 'passenger'. It was set to '${package_source}'")
      }
    }
  }

  package { 'nginx':
    ensure => $package_ensure,
    name   => $package_name,
  }
}
