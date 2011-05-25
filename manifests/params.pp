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
	$worker_processes = 1
	$worker_connections = 1024
	$multi_accept = off
	$sendfile = on
	$keepalive_timeout = 65
	$tcp_nodelay = on
	$gzip = on
	
	# Setup OS Specific Logging Directories and PID files. 
	case $kernel {
		default { 
			$log_dir = '/var/log/nginx'
			$pid 	 = '/var/run/nginx.pid'
		}
	}
}