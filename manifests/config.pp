class nginx::config inherits nginx::params { 
	
	File { 
		owner => 'root', 
		group => 'root', 
		mode => '0644',
	}
	
	file { '/etc/nginx/sites-enabled':
		ensure => directory,
	}
	
	file { '/etc/nginx/sites-enabled/default':
		ensure => absent,
	}
	
	file { '/etc/nginx/nginx.conf':
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		content => template('nginx/nginx.conf.erb'),
	}
}