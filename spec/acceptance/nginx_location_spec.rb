require 'spec_helper_acceptance'

describe 'nginx::resource::location define:' do
  it 'runs successfully' do
    pp = "
    class { 'nginx': }
    nginx::resource::server { 'www.puppetlabs.com':
      ensure   => present,
      www_root => '/var/www/www.puppetlabs.com',
    }
    nginx::resource::server { 'stage.puppetlabs.com':
      ensure   => present,
      www_root => '/var/www/stage.puppetlabs.com',
    }

    nginx::resource::location { 'static-production':
      ensure      => present,
      server      => 'www.puppetlabs.com',
      location    => '/media',
      www_root    => '/var/www/staticfiles/production',
    }
    nginx::resource::location { 'static-stage':
      ensure      => present,
      server      => 'stage.puppetlabs.com',
      location    => '/media',
      www_root    => '/var/www/staticfiles/stage',
    }
    nginx::resource::location { 'letsencrypt':
      ensure      => present,
      server      => ['www.puppetlabs.com', 'stage.puppetlabs.com'],
      location    => '/.well-known/acme-challenge/',
      www_root    => '/var/www/letsencrypt',
    }
    "
    apply_manifest(pp, catch_failures: true)
  end

  describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain '  root      /var/www/www.puppetlabs.com;' }
    it { is_expected.to contain '  location /media {' }
    it { is_expected.to contain '    root      /var/www/staticfiles/production;' }
    it { is_expected.not_to contain '    root      /var/www/staticfiles/stage;' }
    it { is_expected.to contain '  location /.well-known/acme-challenge/ {' }
    it { is_expected.to contain '    root      /var/www/letsencrypt;' }
  end
  describe file('/etc/nginx/sites-available/stage.puppetlabs.com.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain '  root      /var/www/stage.puppetlabs.com;' }
    it { is_expected.to contain '  location /media {' }
    it { is_expected.to contain '    root      /var/www/staticfiles/stage;' }
    it { is_expected.not_to contain '    root      /var/www/staticfiles/production;' }
    it { is_expected.to contain '  location /.well-known/acme-challenge/ {' }
    it { is_expected.to contain '    root      /var/www/letsencrypt;' }
  end

  describe service('nginx') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe port(80) do
    it { is_expected.to be_listening }
  end
end
