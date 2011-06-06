define nginx::resource::vhost(
	$ensure           = 'enable',
	$listen_ip        = '*',
	$listen_port      = '80',
	$ipv6_enable      = 'false',
	$ipv6_listen_ip   = '::',
	$ipv6_listen_port = '80',
	$ssl              = 'false',
	$ssl_cert         = undef,
	$ssl_key          = undef,
    $proxy            = undef,
	$index_files      = ['index.html', 'index.htm', 'index.php'],
	$www_root         = undef
) {
	
	File { 
		owner => 'root', 
		group => 'root', 
		mode  => '0644', 
	}
	
	# Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled 
	# and support does not exist for it in the kernel. 
	if ($ipv6_enable == 'true') and ($ipaddress6)  {
		warning('nginx: IPv6 support is not enabled or configured properly')
	}
		
	# Check to see if SSL Certificates are properly defined. 
	if ($ssl == 'true') {
		if ($ssl_cert == undef) or ($ssl_key == undef) {
			fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
		} 
	} 
	
	# Use the File Fragment Pattern to construct the configuration files.
	# Create the base configuration file reference. 
	file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-001":
		ensure => $ensure ? {
			'absent' => absent,
			default	 => 'file',
		},
		content => template('nginx/vhost/vhost_header.erb'),
		notify => Class['nginx::service'],
	}
	
	# Create the default location reference for the vHost
	nginx::resource::location {"${name}-default":
		ensure	     => $ensure,
		vhost        => $name,
		ssl          => $ssl,
		location	 => '/', 	
		proxy		 => $proxy,
		www_root	 => $www_root,
		notify		 => Class['nginx::service'],
	}
	
	# Create a proper file close stub.
	file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-699":
		ensure => $ensure ? {
			'absent' => absent,
			default	 => 'file',
		},
		content => template('nginx/vhost/vhost_footer.erb'),
		notify => Class['nginx::service'],
	}
	
	# Create SSL File Stubs if SSL is enabled
	if ($ssl == 'true') {
		file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-700-ssl":
			ensure => $ensure ? {
				'absent' => absent,
				default	 => 'file',
			},
			content => template('nginx/vhost/vhost_ssl_header.erb'),
			notify => Class['nginx::service'],
		}
		file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-999-ssl":
			ensure => $ensure ? {
				'absent' => absent,
				default	 => 'file',
			},
			content => template('nginx/vhost/vhost_footer.erb'),
			notify => Class['nginx::service'],
		}
	}	
}