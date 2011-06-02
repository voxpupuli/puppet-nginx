# Class: nginx
#
# This module manages nginx
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class nginx {
	include nginx::package
	include nginx::config
	include nginx::service
	
	Class['nginx::package'] -> Class['nginx::config'] ~> Class['nginx::service']

}
