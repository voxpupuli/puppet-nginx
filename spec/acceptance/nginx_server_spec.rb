require 'spec_helper_acceptance'

describe 'nginx::resource::server define:' do
  context 'new server on port 80' do
    it 'configures a nginx server' do
      pp = "
      class { 'nginx': }
      nginx::resource::server { 'www.puppetlabs.com':
        ensure   => present,
        www_root => '/var/www/www.puppetlabs.com',
      }
      host { 'www.puppetlabs.com': ip => '127.0.0.1', }
      file { ['/var/www','/var/www/www.puppetlabs.com']: ensure => directory }
      file { '/var/www/www.puppetlabs.com/index.html': ensure  => file, content => 'Hello from www\n', }
      "

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'www.puppetlabs.com' }
    end

    describe file('/etc/nginx/sites-enabled/www.puppetlabs.com.conf') do
      it { is_expected.to be_linked_to '/etc/nginx/sites-available/www.puppetlabs.com.conf' }
    end

    describe service('nginx') do
      it { is_expected.to be_running }
    end

    describe port(80) do
      it { is_expected.to be_listening }
    end

    it 'answers to www.puppetlabs.com and responds with "Hello from www"' do
      shell('/usr/bin/curl http://www.puppetlabs.com:80') do |r|
        expect(r.stdout).to eq("Hello from www\n")
      end
    end

    it 'answers to www.puppetlabs.com without error' do
      shell('/usr/bin/curl --fail http://www.puppetlabs.com:80') do |r|
        expect(r.exit_code).to be_zero
      end
    end
  end

  context 'should run successfully with ssl' do
    it 'configures a nginx SSL server' do
      pp = "
      class { 'nginx': }
      nginx::resource::server { 'www.puppetlabs.com':
        ensure   => present,
        ssl      => true,
        ssl_cert => '/etc/pki/tls/certs/blah.cert',
        ssl_key  => '/etc/pki/tls/private/blah.key',
        www_root => '/var/www/www.puppetlabs.com',
      }
      host { 'www.puppetlabs.com': ip => '127.0.0.1', }
      file { ['/var/www','/var/www/www.puppetlabs.com']: ensure => directory }
      file { '/var/www/www.puppetlabs.com/index.html': ensure  => file, content => 'Hello from www\n', }
      "

      apply_manifest(pp, catch_failures: true)
    end

    describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
      it { is_expected.to be_file }
      it { is_expected.not_to contain 'ssl on;' } # As of nginx 1.15 (1.16 stable), this will not be set.
      it { is_expected.to contain 'listen       *:443 ssl;' }
      it { is_expected.not_to contain 'shared:SSL:10m;' }
    end

    describe file('/etc/nginx/sites-enabled/www.puppetlabs.com.conf') do
      it { is_expected.to be_linked_to '/etc/nginx/sites-available/www.puppetlabs.com.conf' }
    end

    describe service('nginx') do
      it { is_expected.to be_running }
    end

    describe port(443) do
      it { is_expected.to be_listening }
    end

    it 'answers to http://www.puppetlabs.com with "Hello from www"' do
      shell('/usr/bin/curl http://www.puppetlabs.com:80') do |r|
        expect(r.stdout).to eq("Hello from www\n")
      end
    end

    it 'answers to http://www.puppetlabs.com without error' do
      shell('/usr/bin/curl --fail http://www.puppetlabs.com:80') do |r|
        expect(r.exit_code).to eq(0)
      end
    end

    it 'answers to https://www.puppetlabs.com with "Hello from www"' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --insecure https://www.puppetlabs.com:443') do |r|
        expect(r.stdout).to eq("Hello from www\n")
      end
    end

    it 'answers to https://www.puppetlabs.com without error' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --fail --insecure https://www.puppetlabs.com:443') do |r|
        expect(r.exit_code).to eq(0)
      end
    end
  end

  context 'should run successfully with encrypted ssl key' do
    it 'configures a nginx SSL server' do
      pp = "
      class { 'nginx': }
      nginx::resource::server { 'www.puppetlabs.com':
        ensure            => present,
        ssl               => true,
        ssl_cache         => 'shared:SSL:10m',
        ssl_cert          => '/etc/pki/tls/certs/crypted.cert',
        ssl_key           => '/etc/pki/tls/private/crypted.key',
        ssl_password_file => '/etc/pki/tls/private/crypted.pass',
        www_root          => '/var/www/www.puppetlabs.com',
      }
      host { 'www.puppetlabs.com': ip => '127.0.0.1', }
      file { ['/var/www','/var/www/www.puppetlabs.com']: ensure => directory }
      file { '/var/www/www.puppetlabs.com/index.html': ensure  => file, content => 'Hello from www\n', }
      "

      apply_manifest(pp, catch_failures: true)
    end

    describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'ssl_session_cache         shared:SSL:10m;' }
      it { is_expected.to contain 'ssl_password_file         /etc/pki/tls/private/crypted.pass;' }
    end

    describe service('nginx') do
      it { is_expected.to be_running }
    end

    describe port(443) do
      it { is_expected.to be_listening }
    end

    it 'answers to https://www.puppetlabs.com with "Hello from www"' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --insecure https://www.puppetlabs.com:443') do |r|
        expect(r.stdout).to eq("Hello from www\n")
      end
    end

    it 'answers to https://www.puppetlabs.com without error' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --fail --insecure https://www.puppetlabs.com:443') do |r|
        expect(r.exit_code).to eq(0)
      end
    end
  end

  context 'should run successfully with ssl_redirect' do
    it 'configures a nginx SSL server' do
      pp = "
      class { 'nginx': }
      nginx::resource::server { 'www.puppetlabs.com':
        ensure       => present,
        ssl          => true,
        ssl_cert     => '/etc/pki/tls/certs/blah.cert',
        ssl_key      => '/etc/pki/tls/private/blah.key',
        ssl_redirect => true,
        www_root     => '/var/www/www.puppetlabs.com',
      }
      nginx::resource::location { 'letsencrypt':
        location    => '^~ /.well-known/acme-challenge',
        www_root    => '/var/www/letsencrypt',
        index_files => [],
        ssl         => false,
        server      => ['www.puppetlabs.com'],
      }
      host { 'www.puppetlabs.com': ip => '127.0.0.1', }
      file { ['/var/www','/var/www/www.puppetlabs.com','/var/www/letsencrypt','/var/www/letsencrypt/.well-known','/var/www/letsencrypt/.well-known/acme-challenge']: ensure => directory }
      file { '/var/www/www.puppetlabs.com/index.html': ensure  => file, content => 'Hello from www\n', }
      file { '/var/www/letsencrypt/.well-known/acme-challenge/fb9bd98604be3d0c7d589fcc7561cb41': ensure  => file, content => 'LetsEncrypt\n', }
      "

      apply_manifest(pp, catch_failures: true)
    end

    describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'return 301 https://$host$request_uri;' }
    end

    describe service('nginx') do
      it { is_expected.to be_running }
    end

    describe port(80) do
      it { is_expected.to be_listening }
    end

    describe port(443) do
      it { is_expected.to be_listening }
    end

    it 'answers to http://www.puppetlabs.com with redirect to HTTPS' do
      shell('/usr/bin/curl -I http://www.puppetlabs.com:80') do |r|
        expect(r.stdout).to contain('301 Moved Permanently')
      end
    end

    it 'answers to http://www.puppetlabs.com with redirect to HTTPS' do
      shell('/usr/bin/curl -I http://www.puppetlabs.com:80') do |r|
        expect(r.stdout).to contain('Location: https://www.puppetlabs.com')
      end
    end

    it 'answers to http://www.puppetlabs.com without error' do
      shell('/usr/bin/curl --fail http://www.puppetlabs.com:80') do |r|
        expect(r.exit_code).to eq(0)
      end
    end

    it 'answers to https://www.puppetlabs.com with "Hello from www"' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --insecure https://www.puppetlabs.com:443') do |r|
        expect(r.stdout).to eq("Hello from www\n")
      end
    end

    it 'answers to http://www.puppetlabs.com/.well-known/acme-challenge/fb9bd98604be3d0c7d589fcc7561cb41 with "LetsEncrypt"' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl http://www.puppetlabs.com:80/.well-known/acme-challenge/fb9bd98604be3d0c7d589fcc7561cb41') do |r|
        expect(r.stdout).to eq("LetsEncrypt\n")
      end
    end

    it 'answers to https://www.puppetlabs.com/.well-known/acme-challenge/fb9bd98604be3d0c7d589fcc7561cb41 with "LetsEncrypt"' do
      # use --insecure because it's a self-signed cert
      shell('/usr/bin/curl --insecure https://www.puppetlabs.com:443/.well-known/acme-challenge/fb9bd98604be3d0c7d589fcc7561cb41') do |r|
        expect(r.stdout).to contain('404 Not Found')
      end
    end
  end
end
