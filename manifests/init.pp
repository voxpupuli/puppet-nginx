class nginx {
	include nginx::package
	include nginx::config
	include nginx::service
	
	Class['nginx::package'] -> Class['nginx::config'] ~> Class['nginx::service']
}
