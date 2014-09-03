# Class: nginx
#
# This module manages NGINX.
#
# This class is basically a factory class used to instantiate the module.
# Instead of attempting to define every logic path for a package and/or
# service class, this class instead allows the user to define the
# classes necessary to bootstrap and manage the service (if even desired!)
#
# This allows the user to use site-specific classes for installing a package,
# or to manage a service. We include some default classes to be used,
# but this should allow a good deal of flexibility for the user.
#
# Parameters:
#
#  [*package_class*]
#    The class(es) that will be used to install nginx. 
#    Takes a string (or array of classes if Puppet 3)
#
#  [*service_class*]
#    The class(es) that will be used to manage nginx service. 
#    Takes a string (or array of classes if Puppet 3)
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#  puppetlabs-concat - https://github.com/puppetlabs/puppetlabs-concat
#  ripineaar-module_data - https://github.com/ripienaar/puppet-module-data/
#
# Sample Usage:
#
# node default {
#   include nginx
# }
class nginx(
  $package_class = "nginx::package::${::osfamily}",
  $service_class = "nginx::service::init",
) {
  $_package_class = downcase($package_class)

  include ::nginx::config

  if $package_class != undef {
    include $_package_class

    Class[$package_class] -> Class['nginx::config']
  }

  if $service_class != undef {
    include $service_class

    Class['nginx::config'] ~> Class[$service_class] 
  }
}
