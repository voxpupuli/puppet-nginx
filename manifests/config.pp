class nginx::config { 
	$daemon_user = $operatingsystem ? {
		/(debian|ubuntu)/ 	   => 'www-data',
		/(fedora|rhel|centos)/ => 'nginx',
	}
	user { $daemon_user: 
		ensure => present,
	}
	group { $daemon_user:
		ensure => present,
	}
	file { '/etc/nginx/nginx.conf':
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		content => template('nginx/nginx.conf.erb'),
		require => Class['nginx::install'],
		notify  => Class['nginx::service'],
	}
	file { '/etc/nginx/sites-available':
		ensure  => directory,
		owner   => 'root',
		group   => 'root', 
		require => Class['nginx::install'],
	}
	file { '/etc/nginx/sites-enabled':
		ensure  => directory,
		owner   => 'root',
		group   => 'root', 
		require => Class['nginx::install'],
	}
}