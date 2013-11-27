# define: nginx::resource::raw_vhost
#
# This definition creates a virtual host
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::raw_vhost { 'ssl':
#    ensure => present,
#    ssl_config => {
#      'enabled'  => true,
#      'cert' => '/etc/ssl/server.crt',
#      'key'  => '/etc/ssl/server.key',
#          port               => '443',
#          protocols          => 'SSLv3 TLSv1 TLSv1.1 TLSv1.2',
#          ciphers            => 'HIGH:!aNULL:!MD5',
#          cache              => 'shared:SSL:10m',
#    },
#    config => {
#      'listen' => '*:8080',
#      'server_name' => ['_'],
#      'proxy_set_header' => [
#        'Host $http_host',
#        'X-Forwarded_host $http_host',
#        'X-Real-IP $remote_addr',
#        'X-Forwarded-For $proxy_add_x_forwarded_for',
#        'HTTPS "on"',
#        'Accept-Encoding ""',
#      ],
#      'proxy_hide_header' => [
#        'X-Varnish',
#        'Via',
#      ],
#      'proxy_pass' => 'http://127.0.0.1',
#    },
#  }

define nginx::resource::raw_vhost (
  $ensure                 = 'enable',
  $rewrite_www_to_non_www = false,
  $rewrite_to_https       = undef,
  $ipv6_enable            = false,
  $ssl_config             = {
      enabled                => false,
	  cert               => undef,
	  key                => undef,
	  port               => '443',
	  protocols          => 'SSLv3 TLSv1 TLSv1.1 TLSv1.2',
	  ciphers            => 'HIGH:!aNULL:!MD5',
	  cache              => 'shared:SSL:10m',
  },
  $config                 = {
	  listen                 => [
	  	'*'
	  ],
	  ipv6_listen            => [],
	  server_name            => [$name],

	  index_files            => [
		'index.html',
		'index.htm',
	  ],
	  access_log             => undef,
	  error_log              => undef,
  },
) {

  validate_hash($config)
  validate_hash($ssl_config)

  File {
    ensure => $ensure ? {
      'absent' => absent,
      default  => 'file',
    },
    notify => Class['nginx::service'],
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if ($ipv6_enable == true) and (!$config[ipv6_listen]) {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl_config[enabled] == true) {
    if ($ssl_config[cert] == undef) or ($ssl_config[key] == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }

  # This was a lot to add up in parameter list so add it down here
  # Also opted to add more logic here and keep template cleaner which
  # unfortunately means resorting to the $varname_real thing
  $domain_log_name = regsubst($name, ' ', '_', 'G')
  $access_log_real = $access_log ? {
    undef   => "${nginx::params::nx_logdir}/${domain_log_name}.access.log",
    default => $access_log,
  }
  $error_log_real = $error_log ? {
    undef   => "${nginx::params::nx_logdir}/${domain_log_name}.error.log",
    default => $error_log,
  }

  if $fastcgi != undef and !defined(File['/etc/nginx/fastcgi_params']) {
    file { '/etc/nginx/fastcgi_params':
      ensure  => present,
      mode    => '0770',
      content => template('nginx/vhost/fastcgi_params.erb'),
    }
  }

  # Use the File Fragment Pattern to construct the configuration files.
  # Create the base configuration file reference.
	file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-1001":
	  ensure  => $ensure ? {
		'absent' => absent,
		default  => 'file',
	  },
	  content => template('nginx/vhost/vhost_raw_header.erb'),
	  notify  => Class['nginx::service'],
	}

  # Create SSL File Stubs if SSL is enabled
  if ($ssl_config['enabled'] == true) {
    # Access and error logs are named differently in ssl template
    $ssl_access_log = $access_log ? {
      undef   => "${nginx::params::nx_logdir}/ssl-${domain_log_name}.access.log",
      default => $access_log,
    }
    $ssl_error_log = $error_log ? {
      undef   => "${nginx::params::nx_logdir}/ssl-${domain_log_name}.error.log",
      default => $error_log,
    }
  }

  # Create a proper file close stub.
  file { "${nginx::config::nx_temp_dir}/nginx.d/${name}-9999": content => template('nginx/vhost/vhost_raw_footer.erb'), }
}
