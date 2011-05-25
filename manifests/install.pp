class nginix::install {
	
	# prepopulating a potential install for non-Linux distros. 
  	$package = $operatingsystem ? {
		/(ubuntu|debian|centos|fedora|rhel)/ => 'nginx'
	}
	
  	package { $package:
		name    => 'nginx',
		ensure  => installed,
  	}
}