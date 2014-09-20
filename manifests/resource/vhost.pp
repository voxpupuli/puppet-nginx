# See README.md for usage information
define nginx::resource::vhost (
  $ensure                 = 'present',
  $listen_ip              = '*',
  $listen_port            = '80',
  $listen_options         = undef,
  $location_allow         = [],
  $location_deny          = [],
  $ipv6_enable            = false,
  $ipv6_listen_ip         = '::',
  $ipv6_listen_port       = '80',
  $ipv6_listen_options    = 'default ipv6only=on',
  $add_header             = undef,
  $ssl                    = false,
  $ssl_listen_option      = true,
  $ssl_cert               = undef,
  $ssl_dhparam            = undef,
  $ssl_key                = undef,
  $ssl_port               = '443',
  $ssl_protocols          = 'SSLv3 TLSv1 TLSv1.1 TLSv1.2',
  $ssl_ciphers            = 'HIGH:!aNULL:!MD5',
  $ssl_cache              = 'shared:SSL:10m',
  $ssl_stapling           = false,
  $ssl_stapling_file      = undef,
  $ssl_stapling_responder = undef,
  $ssl_stapling_verify    = false,
  $ssl_session_timeout    = '5m',
  $ssl_trusted_cert       = undef,
  $spdy                   = $nginx::config::spdy,
  $proxy                  = undef,
  $proxy_redirect         = undef,
  $proxy_read_timeout     = $nginx::config::proxy_read_timeout,
  $proxy_connect_timeout  = $nginx::config::proxy_connect_timeout,
  $proxy_set_header       = [],
  $proxy_cache            = false,
  $proxy_cache_valid      = false,
  $proxy_method           = undef,
  $proxy_set_body         = undef,
  $resolver               = [],
  $fastcgi                = undef,
  $fastcgi_params         = "${nginx::config::conf_dir}/fastcgi_params",
  $fastcgi_script         = undef,
  $index_files            = [
    'index.html',
    'index.htm',
    'index.php'],
  $autoindex              = undef,
  $server_name            = [$name],
  $www_root               = undef,
  $rewrite_www_to_non_www = false,
  $rewrite_to_https       = undef,
  $location_custom_cfg    = undef,
  $location_cfg_prepend   = undef,
  $location_cfg_append    = undef,
  $location_custom_cfg_prepend  = undef,
  $location_custom_cfg_append   = undef,
  $try_files              = undef,
  $auth_basic             = undef,
  $auth_basic_user_file   = undef,
  $client_body_timeout    = undef,
  $client_header_timeout  = undef,
  $client_max_body_size   = undef,
  $raw_prepend            = undef,
  $raw_append             = undef,
  $location_raw_prepend   = undef,
  $location_raw_append    = undef,
  $vhost_cfg_prepend      = undef,
  $vhost_cfg_append       = undef,
  $vhost_cfg_ssl_prepend      = undef,
  $vhost_cfg_ssl_append       = undef,
  $include_files          = undef,
  $access_log             = undef,
  $error_log              = undef,
  $format_log             = undef,
  $passenger_cgi_param    = undef,
  $log_by_lua             = undef,
  $log_by_lua_file        = undef,
  $use_default_location   = true,
  $rewrite_rules          = [],
  $string_mappings        = {},
  $geo_mappings           = {},
  $gzip_types             = undef,
  $owner                  = $nginx::config::global_owner,
  $group                  = $nginx::config::global_group,
  $mode                   = $nginx::config::global_mode,
) {

  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")
  validate_string($listen_ip)
  if !is_integer($listen_port) {
    fail('$listen_port must be an integer.')
  }
  if ($listen_options != undef) {
    validate_string($listen_options)
  }
  validate_array($location_allow)
  validate_array($location_deny)
  validate_bool($ipv6_enable)
  validate_string($ipv6_listen_ip)
  if !is_integer($ipv6_listen_port) {
    fail('$ipv6_listen_port must be an integer.')
  }
  validate_string($ipv6_listen_options)
  if ($add_header != undef) {
    validate_hash($add_header)
  }
  validate_bool($ssl)
  if ($ssl_cert != undef) {
    validate_string($ssl_cert)
  }
  validate_bool($ssl_listen_option)
  if ($ssl_dhparam != undef) {
    validate_string($ssl_dhparam)
  }
  if ($ssl_key != undef) {
    validate_string($ssl_key)
  }
  if !is_integer($ssl_port) {
    fail('$ssl_port must be an integer.')
  }
  validate_string($ssl_protocols)
  validate_string($ssl_ciphers)
  validate_string($ssl_cache)
  validate_bool($ssl_stapling)
  if ($ssl_stapling_file != undef) {
    validate_string($ssl_stapling_file)
  }
  if ($ssl_stapling_responder != undef) {
    validate_string($ssl_stapling_responder)
  }
  validate_bool($ssl_stapling_verify)
  validate_string($ssl_session_timeout)
  if ($ssl_trusted_cert != undef) {
    validate_string($ssl_trusted_cert)
  }
  validate_string($spdy)
  if ($proxy != undef) {
    validate_string($proxy)
  }
  validate_string($proxy_read_timeout)
  validate_string($proxy_redirect)
  validate_array($proxy_set_header)
  if ($proxy_cache != false) {
    validate_string($proxy_cache)
  }
  if ($proxy_cache_valid != false) {
    validate_string($proxy_cache_valid)
  }
  if ($proxy_method != undef) {
    validate_string($proxy_method)
  }
  if ($proxy_set_body != undef) {
    validate_string($proxy_set_body)
  }
  validate_array($resolver)
  if ($fastcgi != undef) {
    validate_string($fastcgi)
  }
  validate_string($fastcgi_params)
  if ($fastcgi_script != undef) {
    validate_string($fastcgi_script)
  }
  validate_array($index_files)
  if ($autoindex != undef) {
    validate_string($autoindex)
  }
  validate_array($server_name)
  if ($www_root != undef) {
    validate_string($www_root)
  }
  validate_bool($rewrite_www_to_non_www)
  if ($rewrite_to_https != undef) {
    validate_bool($rewrite_to_https)
  }
  if ($raw_prepend != undef) {
    if (is_array($raw_prepend)) {
      validate_array($raw_prepend)
    } else {
      validate_string($raw_prepend)
    }
  }
  if ($raw_append != undef) {
    if (is_array($raw_append)) {
      validate_array($raw_append)
    } else {
      validate_string($raw_append)
    }
  }
  if ($location_raw_prepend != undef) {
    if (is_array($location_raw_prepend)) {
      validate_array($location_raw_prepend)
    } else {
      validate_string($location_raw_prepend)
    }
  }
  if ($location_raw_append != undef) {
    if (is_array($location_raw_append)) {
      validate_array($location_raw_append)
    } else {
      validate_string($location_raw_append)
    }
  }
  if ($location_custom_cfg != undef) {
    validate_hash($location_custom_cfg)
  }
  if ($location_cfg_prepend != undef) {
    validate_hash($location_cfg_prepend)
  }
  if ($location_cfg_append != undef) {
    validate_hash($location_cfg_append)
  }
  if ($try_files != undef) {
    validate_array($try_files)
  }
  if ($auth_basic != undef) {
    validate_string($auth_basic)
  }
  if ($auth_basic_user_file != undef) {
    validate_string($auth_basic_user_file)
  }
  if ($vhost_cfg_prepend != undef) {
    validate_hash($vhost_cfg_prepend)
  }
  if ($vhost_cfg_append != undef) {
    validate_hash($vhost_cfg_append)
  }
  if ($vhost_cfg_ssl_prepend != undef) {
    validate_hash($vhost_cfg_ssl_prepend)
  }
  if ($vhost_cfg_ssl_append != undef) {
    validate_hash($vhost_cfg_ssl_append)
  }
  if ($include_files != undef) {
    validate_array($include_files)
  }
  if ($access_log != undef) {
    validate_string($access_log)
  }
  if ($error_log != undef) {
    validate_string($error_log)
  }
  if ($passenger_cgi_param != undef) {
    validate_hash($passenger_cgi_param)
  }
  if ($log_by_lua != undef) {
    validate_string($log_by_lua)
  }
  if ($log_by_lua_file != undef) {
    validate_string($log_by_lua_file)
  }
  if ($client_body_timeout != undef) {
    validate_string($client_body_timeout)
  }
  if ($client_header_timeout != undef) {
    validate_string($client_header_timeout)
  }
  if ($gzip_types != undef) {
    validate_string($gzip_types)
  }
  validate_bool($use_default_location)
  validate_array($rewrite_rules)
  validate_hash($string_mappings)
  validate_hash($geo_mappings)

  validate_string($owner)
  validate_string($group)
  validate_re($mode, '^\d{4}$',
    "${mode} is not valid. It should be 4 digits (0644 by default).")

  # Variables
  $vhost_dir = "${nginx::config::conf_dir}/sites-available"
  $vhost_enable_dir = "${nginx::config::conf_dir}/sites-enabled"
  $vhost_symlink_ensure = $ensure ? {
    'absent' => absent,
    default  => 'link',
  }

  $name_sanitized = regsubst($name, ' ', '_', 'G')
  $config_file = "${vhost_dir}/${name_sanitized}.conf"

  File {
    ensure => $ensure ? {
      'absent' => absent,
      default  => 'file',
    },
    notify => Class['nginx::service'],
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  # Add IPv6 Logic Check - Nginx service will not start if ipv6 is enabled
  # and support does not exist for it in the kernel.
  if ($ipv6_enable == true) and (!$::ipaddress6) {
    warning('nginx: IPv6 support is not enabled or configured properly')
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl == true) {
    if ($ssl_cert == undef) or ($ssl_key == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_key) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }


  # This was a lot to add up in parameter list so add it down here
  # Also opted to add more logic here and keep template cleaner which
  # unfortunately means resorting to the $varname_real thing
  $access_log_tmp = $access_log ? {
    undef   => "${nginx::config::logdir}/${name_sanitized}.access.log",
    default => $access_log,
  }

  $access_log_real = $format_log ? {
    undef   => $access_log_tmp,
    default => "${access_log_tmp} ${format_log}",
  }

  $error_log_real = $error_log ? {
    undef   => "${nginx::config::logdir}/${name_sanitized}.error.log",
    default => $error_log,
  }

  concat { $config_file:
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    notify => Class['nginx::service'],
  }

  $ssl_only = ($ssl == true) and ($ssl_port == $listen_port)

  if $use_default_location == true {
    # Create the default location reference for the vHost
    nginx::resource::location {"${name_sanitized}-default":
      ensure                => $ensure,
      vhost                 => $name_sanitized,
      ssl                   => $ssl,
      ssl_only              => $ssl_only,
      location              => '/',
      location_allow        => $location_allow,
      location_deny         => $location_deny,
      proxy                 => $proxy,
      proxy_redirect        => $proxy_redirect,
      proxy_read_timeout    => $proxy_read_timeout,
      proxy_connect_timeout => $proxy_connect_timeout,
      proxy_cache           => $proxy_cache,
      proxy_cache_valid     => $proxy_cache_valid,
      proxy_method          => $proxy_method,
      proxy_set_body        => $proxy_set_body,
      fastcgi               => $fastcgi,
      fastcgi_params        => $fastcgi_params,
      fastcgi_script        => $fastcgi_script,
      try_files             => $try_files,
      www_root              => $www_root,
      autoindex             => $autoindex,
      index_files           => [],
      location_custom_cfg   => $location_custom_cfg,
      notify                => Class['nginx::service'],
      rewrite_rules         => $rewrite_rules,
      raw_prepend           => $location_raw_prepend,
      raw_append            => $location_raw_append
    }
    $root = undef
  } else {
    $root = $www_root
  }

  # Support location_cfg_prepend and location_cfg_append on default location created by vhost
  if $location_cfg_prepend {
    Nginx::Resource::Location["${name_sanitized}-default"] {
      location_cfg_prepend => $location_cfg_prepend }
  }

  if $location_cfg_append {
    Nginx::Resource::Location["${name_sanitized}-default"] {
      location_cfg_append => $location_cfg_append }
  }

  if $location_custom_cfg_prepend {
    Nginx::Resource::Location["${name_sanitized}-default"] {
      location_custom_cfg_prepend => $location_custom_cfg_prepend }
  }

  if $location_custom_cfg_append {
    Nginx::Resource::Location["${name_sanitized}-default"] {
      location_custom_cfg_append => $location_custom_cfg_append }
  }

  if $fastcgi != undef and !defined(File[$fastcgi_params]) {
    file { $fastcgi_params:
      ensure  => present,
      mode    => '0770',
      content => template('nginx/vhost/fastcgi_params.erb'),
    }
  }

  if ($listen_port != $ssl_port) {
    concat::fragment { "${name_sanitized}-header":
      ensure  => present,
      target  => $config_file,
      content => template('nginx/vhost/vhost_header.erb'),
      order   => '001',
    }
  }

  # Create a proper file close stub.
  if ($listen_port != $ssl_port) {
    concat::fragment { "${name_sanitized}-footer":
      ensure  => present,
      target  => $config_file,
      content => template('nginx/vhost/vhost_footer.erb'),
      order   => '699',
    }
  }

  # Create SSL File Stubs if SSL is enabled
  if ($ssl == true) {
    # Access and error logs are named differently in ssl template

    # This was a lot to add up in parameter list so add it down here
    # Also opted to add more logic here and keep template cleaner which
    # unfortunately means resorting to the $varname_real thing
    $ssl_access_log_tmp = $access_log ? {
      undef   => "${nginx::config::logdir}/ssl-${name_sanitized}.access.log",
      default => $access_log,
    }

    $ssl_access_log_real = $format_log ? {
      undef   => $ssl_access_log_tmp,
      default => "${ssl_access_log_tmp} ${format_log}",
    }

    $ssl_error_log_real = $error_log ? {
      undef   => "${nginx::config::logdir}/ssl-${name_sanitized}.error.log",
      default => $error_log,
    }

    concat::fragment { "${name_sanitized}-ssl-header":
      target  => $config_file,
      content => template('nginx/vhost/vhost_ssl_header.erb'),
      order   => '700',
    }
    concat::fragment { "${name_sanitized}-ssl-footer":
      target  => $config_file,
      content => template('nginx/vhost/vhost_ssl_footer.erb'),
      order   => '999',
    }

    #Generate ssl key/cert with provided file-locations
    $cert = regsubst($name,' ','_', 'G')

    # Check if the file has been defined before creating the file to
    # avoid the error when using wildcard cert on the multiple vhosts
    ensure_resource('file', "${nginx::config::conf_dir}/${cert}.crt", {
      owner  => $nginx::config::daemon_user,
      mode   => '0444',
      source => $ssl_cert,
    })
    ensure_resource('file', "${nginx::config::conf_dir}/${cert}.key", {
      owner  => $nginx::config::daemon_user,
      mode   => '0440',
      source => $ssl_key,
    })
    if ($ssl_dhparam != undef) {
      ensure_resource('file', "${nginx::config::conf_dir}/${cert}.dh.pem", {
        owner  => $nginx::config::daemon_user,
        mode   => '0440',
        source => $ssl_dhparam,
      })
    }
    if ($ssl_stapling_file != undef) {
      ensure_resource('file', "${nginx::config::conf_dir}/${cert}.ocsp.resp", {
        owner  => $nginx::config::daemon_user,
        mode   => '0440',
        source => $ssl_stapling_file,
      })
    }
    if ($ssl_trusted_cert != undef) {
      ensure_resource('file', "${nginx::config::conf_dir}/${cert}.trusted.crt", {
        owner  => $nginx::config::daemon_user,
        mode   => '0440',
        source => $ssl_trusted_cert,
      })
    }
  }

  file{ "${name_sanitized}.conf symlink":
    ensure  => $vhost_symlink_ensure,
    path    => "${vhost_enable_dir}/${name_sanitized}.conf",
    target  => $config_file,
    require => Concat[$config_file],
    notify  => Service['nginx'],
  }

  create_resources('nginx::resource::map', $string_mappings)
  create_resources('nginx::resource::geo', $geo_mappings)
}
