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
end
