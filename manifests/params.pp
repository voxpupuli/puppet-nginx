# Class: nginx::params
# ====================
#
# nginx default settings and according to operating system
#
class nginx::params {
  ### Operating System Configuration
  ## This is my hacky... no hiera system. Oh well. :)
  $_module_defaults = {
    'conf_dir'     => '/etc/nginx',
    'daemon_user'  => 'nginx',
    'pid'          => '/var/run/nginx.pid',
    'root_group'   => 'root',
    'log_dir'      => '/var/log/nginx',
    'log_user'     => 'nginx',
    'log_group'    => 'root',
    'log_mode'     => '0750',
    'run_dir'      => '/var/nginx',
    'package_name' => 'nginx',
    'manage_repo'  => false,
    'mime_types'   => {
      'text/html'                                                                 => 'html htm shtml',
      'text/css'                                                                  => 'css',
      'text/xml'                                                                  => 'xml',
      'image/gif'                                                                 => 'gif',
      'image/jpeg'                                                                => 'jpeg jpg',
      'application/javascript'                                                    => 'js',
      'application/atom+xml'                                                      => 'atom',
      'application/rss+xml'                                                       => 'rss',
      'text/mathml'                                                               => 'mml',
      'text/plain'                                                                => 'txt',
      'text/vnd.sun.j2me.app-descriptor'                                          => 'jad',
      'text/vnd.wap.wml'                                                          => 'wml',
      'text/x-component'                                                          => 'htc',
      'image/png'                                                                 => 'png',
      'image/tiff'                                                                => 'tif tiff',
      'image/vnd.wap.wbmp'                                                        => 'wbmp',
      'image/x-icon'                                                              => 'ico',
      'image/x-jng'                                                               => 'jng',
      'image/x-ms-bmp'                                                            => 'bmp',
      'image/svg+xml'                                                             => 'svg svgz',
      'image/webp'                                                                => 'webp',
      'application/font-woff'                                                     => 'woff',
      'application/java-archive'                                                  => 'jar war ear',
      'application/json'                                                          => 'json',
      'application/mac-binhex40'                                                  => 'hqx',
      'application/msword'                                                        => 'doc',
      'application/pdf'                                                           => 'pdf',
      'application/postscript'                                                    => 'ps eps ai',
      'application/rtf'                                                           => 'rtf',
      'application/vnd.apple.mpegurl'                                             => 'm3u8',
      'application/vnd.ms-excel'                                                  => 'xls',
      'application/vnd.ms-fontobject'                                             => 'eot',
      'application/vnd.ms-powerpoint'                                             => 'ppt',
      'application/vnd.wap.wmlc'                                                  => 'wmlc',
      'application/vnd.google-earth.kml+xml'                                      => 'kml',
      'application/vnd.google-earth.kmz'                                          => 'kmz',
      'application/x-7z-compressed'                                               => '7z',
      'application/x-cocoa'                                                       => 'cco',
      'application/x-java-archive-diff'                                           => 'jardiff',
      'application/x-java-jnlp-file'                                              => 'jnlp',
      'application/x-makeself'                                                    => 'run',
      'application/x-perl'                                                        => 'pl pm',
      'application/x-pilot'                                                       => 'prc pdb',
      'application/x-rar-compressed'                                              => 'rar',
      'application/x-redhat-package-manager'                                      => 'rpm',
      'application/x-sea'                                                         => 'sea',
      'application/x-shockwave-flash'                                             => 'swf',
      'application/x-stuffit'                                                     => 'sit',
      'application/x-tcl'                                                         => 'tcl tk',
      'application/x-x509-ca-cert'                                                => 'der pem crt',
      'application/x-xpinstall'                                                   => 'xpi',
      'application/xhtml+xml'                                                     => 'xhtml',
      'application/xspf+xml'                                                      => 'xspf',
      'application/zip'                                                           => 'zip',
      'application/octet-stream'                                                  => 'bin exe dll deb dmg iso img msi msp msm',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document'   => 'docx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'         => 'xlsx',
      'application/vnd.openxmlformats-officedocument.presentationml.presentation' => 'pptx',
      'audio/midi'                                                                => 'mid midi kar',
      'audio/mpeg'                                                                => 'mp3',
      'audio/ogg'                                                                 => 'ogg',
      'audio/x-m4a'                                                               => 'm4a',
      'audio/x-realaudio'                                                         => 'ra',
      'video/3gpp'                                                                => '3gpp 3gp',
      'video/mp2t'                                                                => 'ts',
      'video/mp4'                                                                 => 'mp4',
      'video/mpeg'                                                                => 'mpeg mpg',
      'video/quicktime'                                                           => 'mov',
      'video/webm'                                                                => 'webm',
      'video/x-flv'                                                               => 'flv',
      'video/x-m4v'                                                               => 'm4v',
      'video/x-mng'                                                               => 'mng',
      'video/x-ms-asf'                                                            => 'asx asf',
      'video/x-ms-wmv'                                                            => 'wmv',
      'video/x-msvideo'                                                           => 'avi',
    },
  }
  case $facts['os']['family'] {
    'ArchLinux': {
      $_module_os_overrides = {
        'pid'          => false,
        'daemon_user'  => 'http',
        'log_user'     => 'http',
        'log_group'    => 'log',
        'package_name' => 'nginx-mainline',
      }
    }
    'Debian': {
      if ($facts['os']['name'] == 'ubuntu' and $facts['lsbdistcodename'] in ['lucid', 'precise', 'trusty', 'xenial', 'bionic'])
      or ($facts['os']['name'] == 'debian' and $facts['os']['release']['major'] in ['6', '7', '8', '9']) {
        $_module_os_overrides = {
          'manage_repo' => true,
          'daemon_user' => 'www-data',
          'log_user'    => 'root',
          'log_group'   => 'adm',
          'log_mode'    => '0755',
        }
      } else {
        $_module_os_overrides = {
          'daemon_user' => 'www-data',
          'log_user'    => 'root',
          'log_group'   => 'adm',
          'log_mode'    => '0755',
        }
      }
    }
    'DragonFly', 'FreeBSD': {
      $_module_os_overrides = {
        'conf_dir'    => '/usr/local/etc/nginx',
        'daemon_user' => 'www',
        'root_group'  => 'wheel',
        'log_group'   => 'wheel',
        'log_user'    => 'root',
      }
    }
    'Gentoo': {
      $_module_os_overrides = {
        'package_name' => 'www-servers/nginx',
      }
    }
    'RedHat': {
      if ($facts['os']['name'] in ['RedHat', 'CentOS', 'Oracle'] and $facts['os']['release']['major'] in ['6', '7']) {
        $_module_os_overrides = {
          'manage_repo' => true,
          'log_group'   => 'nginx',
        }
      } else {
        $_module_os_overrides = {
          'log_group' => 'nginx',
        }
      }
    }
    'Solaris': {
      case $facts['os']['name'] {
        'SmartOS': {
          $_module_os_overrides = {
            'conf_dir'    => '/opt/local/etc/nginx',
            'daemon_user' => 'www',
            'log_user'    => 'www',
            'log_group'   => 'root',
          }
        }
        default: {
          $_module_os_overrides = {
            'daemon_user'  => 'webservd',
            'package_name' => undef,
          }
        }
      }
    }
    'OpenBSD': {
      $_module_os_overrides = {
        'daemon_user' => 'www',
        'root_group'  => 'wheel',
        'log_dir'     => '/var/www/logs',
        'log_user'    => 'www',
        'log_group'   => 'wheel',
        'run_dir'     => '/var/www',
      }
    }
    'AIX': {
      $_module_os_overrides = {
        'daemon_user' => 'nginx',
        'root_group'  => 'system',
        'conf_dir'    => '/opt/freeware/etc/nginx/',
        'log_dir'     => '/opt/freeware/var/log/nginx/',
        'log_group'   => 'system',
        'run_dir'     => '/opt/freeware/share/nginx/html',
      }
    }
    default: {
      ## For cases not covered in $::osfamily
      case $facts['os']['name'] {
        default: { $_module_os_overrides = {} }
      }
    }
  }

  $_module_parameters = merge($_module_defaults, $_module_os_overrides)
  ### END Operating System Configuration

  ### Referenced Variables
  $conf_dir              = $_module_parameters['conf_dir']
  $snippets_dir          = "${conf_dir}/snippets"
  $log_dir               = $_module_parameters['log_dir']
  $log_user              = $_module_parameters['log_user']
  $log_group             = $_module_parameters['log_group']
  $log_mode              = $_module_parameters['log_mode']
  $run_dir               = $_module_parameters['run_dir']
  $temp_dir              = '/tmp'
  $pid                   = $_module_parameters['pid']

  $client_body_temp_path = "${run_dir}/client_body_temp"
  $daemon_user           = $_module_parameters['daemon_user']
  $global_owner          = 'root'
  $global_group          = $_module_parameters['root_group']
  $global_mode           = '0644'
  $http_access_log_file  = 'access.log'
  $manage_repo           = $_module_parameters['manage_repo']
  $mime_types            = $_module_parameters['mime_types']
  $nginx_error_log_file  = 'error.log'
  $root_group            = $_module_parameters['root_group']
  $package_name          = $_module_parameters['package_name']
  $proxy_temp_path       = "${run_dir}/proxy_temp"
  $sites_available_owner = 'root'
  $sites_available_group = $_module_parameters['root_group']
  $sites_available_mode  = '0644'
  $super_user            = true
  ### END Referenced Variables
}
