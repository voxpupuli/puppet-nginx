# Class: nginx::package::suse
#
# This module manages NGINX package installation for SuSE based systems
#
# Parameters:
# 
# There are no default parameters for this class. 
#
# Actions:
#  This module contains all of the required package for SuSE. Apache and all
#  other packages listed below are built into the packaged RPM spec for 
#  SuSE and OpenSuSE. 
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package::suse {
	package { 'nginx-0.8':
		ensure => present,
	}
	package { 'apache2':
		ensure => present,
	}
	package { 'apache2-itk':
		ensure => present,
	}
	package { 'apache2-utils':
		ensure => present,
	}
	package { 'gd':
		ensure => present,
	}
	package { "libapr1":
		ensure => installed,
	}
	package { "libapr-util1":
		ensure => installed,
	}
	package { "libjpeg62":
		ensure => installed,
	}
	package { "libpng14-14":
		ensure => installed,
	}
	package { "libxslt":
		ensure => installed,
	}
	package { "rubygem-daemon_controller":
		ensure => installed,
	}
	package { "rubygem-fastthread":
		ensure => installed,
	}
	package { "rubygem-file-tail":
		ensure => installed,
	}
	package { "rubygem-passenger":
		ensure => installed,
	}
	package { "rubygem-passenger-nginx":
		ensure => installed,
	}
	package { "rubygem-rack":
		ensure => installed,
	}
	package { "rubygem-rake":
		ensure => installed,
	}
	package { "rubygem-spruz":
		ensure => installed,
	}
}
