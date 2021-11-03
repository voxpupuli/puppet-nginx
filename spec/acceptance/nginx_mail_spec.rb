# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'nginx::resource::mailhost define:' do
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
    }
    "

    apply_manifest(pp, catch_failures: true)
  end

  describe file('/etc/nginx/conf.mail.d/domain1.example.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain 'auth_http             localhost/cgi-bin/auth;' }
    it { is_expected.to contain 'listen                *:465 ssl;' }
  end

  # rubocop:disable RSpec/RepeatedExampleGroupBody
  describe port(587) do
    it { is_expected.to be_listening }
  end

  describe port(465) do
    it { is_expected.to be_listening }
  end
  # rubocop:enable RSpec/RepeatedExampleGroupBody

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
        expect(subject).to contain 'listen                *:465;'
      end
    end
  end
end
