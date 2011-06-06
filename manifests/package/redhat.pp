# Class: nginx::package::redhat
#
# This module manages NGINX package installation on RedHat based systems
#
# Parameters:
# 
# There are no default parameters for this class. 
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package::redhat {
	package { 'nginx':
		ensure => present,
	}
	package { 'GeoIP':
		ensure => present,
	}
	package { 'gd':
		ensure => present,
	}
	package { 'libXpm':
		ensure => present,
	}
	package { 'libxslt':
		ensure => present,
	}
}