define nginx::vhost(
	$listen = '*',
	$listen_port,
	$www_root,
	$ssl = 'off',
	$ssl_cert,
	$ssl_key,
	$location,
	$state = 'enable',
) {
	file { "/etc/nginx/sites-available/${name}":
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '0644',
		content => template('nginx/vhost.erb')
	}
	file { "/etc/nginx/sites-enabled/${name}":
		ensure => $state ? {
			'disable' => absent,
			default	  => 'symlink',
		}
		target => "/etc/nginx/sites-available/${name}",
	}
}