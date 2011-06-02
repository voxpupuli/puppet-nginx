class nginx::package {
	
	package { 'nginx': 
		ensure => present,
	}
	
	case $operatingsystem {
		rhel,centos,oel: {
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
	}
}