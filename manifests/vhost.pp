define nginx::vhost(
	$ensure 			= 'enable',
	$listen_ip 			= '*',
	$listen_port 		= '80',
	$ipv6_enable 		= 'false',
	$ipv6_listen_ip 	= '::',
	$ipv6_listen_port 	= '80',
	$ssl 				= 'false',
	$ssl_cert 			= undef,
	$ssl_key 			= undef,
	$index_files		= ['index.html', 'index.htm', 'index.php'],
	$www_root
) {
	
	# Check to see if SSL Certificates are properly defined
	if ($ssl == 'true') {
		if ($ssl_cert == undef) {
			fail('SSL Certificate (ssl_cert) must be defined and exist on the target system(s)')
		} elsif ($ssl_key == undef) {
			fail('SSL Private Key (ssl_key) must be defined and exist on the target system(s)')
		}
	} 
	
	file { "/etc/nginx/sites-enabled/${name}":
		ensure => $ensure ? {
			'absent' => absent,
			default	 => 'file',
		},
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => template('nginx/vhost.erb'),
		notify => Class['nginx::service'],
	}
}