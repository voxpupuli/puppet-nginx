# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'nginx::resource::mailhost define:' do
  has_recent_mail_module = true

  if fact('os.family') == 'RedHat' && fact('os.release.major') == '8'
    # EPEL had recent nginx-mod-mail package for CentOS 7 but not CentOS 8
    # Stream.  The base packages use an older version of nginx that does not
    # work with the acceptance test configuration.
    has_recent_mail_module = false
  end

  it 'remove leftovers from previous tests', if: fact('os.family') == 'RedHat' do
    shell('yum -y remove nginx nginx-filesystem passenger')
    # nginx-mod-mail is not available for all versions of nginx, the one
    # installed might be incompatible with the version of nginx-mod-mail we are
    # about to install so clean everything.
    pp = "
    yumrepo { 'nginx-release':
      ensure => absent,
    }
    yumrepo { 'passenger':
      ensure => absent,
    }
    "
    apply_manifest(pp, catch_failures: true)
  end

  context 'actualy test the mail module', if: has_recent_mail_module do
    it 'runs successfully' do
      pp = "
      if fact('os.family') == 'RedHat' {
        package { 'nginx-mod-mail':
          ensure => installed,
        }
      }

      class { 'nginx':
        mail            => true,
        dynamic_modules => fact('os.family') ? {
          'RedHat' => ['/usr/lib64/nginx/modules/ngx_mail_module.so'],
          default  => [],
        }
      }
      nginx::resource::mailhost { 'domain1.example':
        ensure      => present,
        auth_http   => 'localhost/cgi-bin/auth',
        protocol    => 'smtp',
        listen_port => 587,
        ssl         => true,
        ssl_port    => 465,
        ssl_cert    => '/etc/pki/tls/certs/blah.cert',
        ssl_key     => '/etc/pki/tls/private/blah.key',
        xclient     => 'off',
        proxy_protocol  => 'off',
        proxy_smtp_auth => 'off',
      }
      "

      apply_manifest(pp, catch_failures: true)
      # The module produce different config when nginx is installed and when it
      # is not installed prior to getting facts, so we need to re-apply the
      # catalog.
      apply_manifest(pp, catch_failures: true)
    end

    describe file('/etc/nginx/conf.mail.d/domain1.example.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'auth_http             localhost/cgi-bin/auth;' }
      it { is_expected.to contain 'listen                *:465 ssl;' }
    end

    describe port(587) do
      it { is_expected.to be_listening }
    end

    describe port(465) do
      it { is_expected.to be_listening }
    end

    context 'when configured for nginx 1.14' do
      it 'runs successfully' do
        pp = "
      if fact('os.family') == 'RedHat' {
        package { 'nginx-mod-mail':
          ensure => installed,
        }
      }

      class { 'nginx':
        mail            => true,
        nginx_version   => '1.14.0',
        dynamic_modules => fact('os.family') ? {
          'RedHat' => ['/usr/lib64/nginx/modules/ngx_mail_module.so'],
          default  => [],
        }
      }
      nginx::resource::mailhost { 'domain1.example':
        ensure      => present,
        auth_http   => 'localhost/cgi-bin/auth',
        protocol    => 'smtp',
        listen_port => 587,
        ssl         => true,
        ssl_port    => 465,
        ssl_cert    => '/etc/pki/tls/certs/blah.cert',
        ssl_key     => '/etc/pki/tls/private/blah.key',
        xclient     => 'off',
      }
        "

        apply_manifest(pp, catch_failures: true)
      end

      describe file('/etc/nginx/conf.mail.d/domain1.example.conf') do
        it 'does\'t contain `ssl` on `listen` line' do
          is_expected.to contain 'listen                *:465;'
        end
      end
    end
  end
end
