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