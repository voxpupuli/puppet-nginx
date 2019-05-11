require 'spec_helper_acceptance'

describe 'nginx::resource::mailhost define:' do
  it 'runs successfully' do
    pp = "
    class { 'nginx':
      mail => true,
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

  describe port(587) do
    it { is_expected.to be_listening }
  end

  describe port(465) do
    it { is_expected.to be_listening }
  end

  context 'when configured for nginx 1.14' do
    it 'runs successfully' do
      pp = "
    class { 'nginx':
      mail          => true,
      nginx_version => '1.14.0',
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
