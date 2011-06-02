# Defines a default install from package. Update as appropriate for base install.
#######################################################################
#
# This is the main Nginx configuration file.  
#
# More information about the configuration options is available on 
#   * the English wiki - http://wiki.nginx.org/Main
#   * the Russian documentation - http://sysoev.ru/nginx/
#
#######################################################################

class nginx::params {
	$nx_worker_processes = 1
	$nx_worker_connections = 1024
	$nx_multi_accept = off
	$nx_sendfile = on
	$nx_keepalive_timeout = 65
	$nx_tcp_nodelay = on
	$nx_gzip = on
	
	$nx_logdir = $kernel ? {
		/(?i-mx:linux)/ => '/var/log/nginx',
	}
	
	$nx_pid = $kernel ? {
		/(?i-mx:linux)/  => '/var/run/nginx.pid',
	}
	
	$nx_daemon_user = $operatingsystem ? {
		/(?i-mx:debian|ubuntu)/ 	   => 'www-data',
		/(?i-mx:fedora|rhel|centos)/ => 'nginx',
	}
}