define nginx::resource::location( 
	$ensure         = 'present',
    $vhost          = undef,
    $location,
	$www_root       = undef,
	$index_files    = ['index.html', 'index.htm', 'index.php'],
	$proxy          = undef,
	$ssl		    = 'false',
    $option	        = undef
){
	File { 
		owner  => 'root', 
		group  => 'root', 
		mode   => '0644', 
		notify => Class['nginx::service'],
	}
	
	## Shared Variables
	$ensure_real = $ensure ? {
		'absent' => absent,
		default	 => 'file',
	}
	
	# Use proxy template if $proxy is defined, otherwise use directory template.  
	if ($proxy != undef) {
		$content_real = template('nginx/vhost/vhost_location_proxy.erb')
	} else {
		$content_real = template('nginx/vhost/vhost_location_directory.erb')
	}
	
	## Check for various error condtiions
	if ($vhost == undef) {
		fail('Cannot create a location reference without attaching to a virtual host')
	}
	if (($www_root == undef) and ($proxy == undef)) {
		fail('Cannot create a location reference without a www_root or proxy defined')
	}
	if (($www_root != undef) and ($proxy != undef)) {
		fail('Cannot define both directory and proxy in a virtual host')
	}
	
	
	## Create stubs for vHost File Fragment Pattern 
	file {"${nginx::config::nx_temp_dir}/nginx.d/${vhost}-500-${name}":
		ensure  => $ensure_real,
		content => $content_real,
	}
	
	## Only create SSL Specific locations if $ssl is true. 
	if ($ssl == 'true') {
	  file {"${nginx::config::nx_temp_dir}/nginx.d/${vhost}-800-${name}-ssl":
		  ensure  => $ensure_real,
		  content => $content_re,
	  }
    }
}