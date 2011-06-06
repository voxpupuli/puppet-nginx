class nginx::package::debian {
	package { 'nginx':
		ensure => present,
	}
}