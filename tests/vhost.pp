include nginix

nginix::vhost { 'www.test.com':
	port 	=> '80',
	webroot => "/opt/www/test",
	ssl		=> false, 
}