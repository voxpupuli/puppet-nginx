require 'spec_helper_acceptance'

describe 'nginx::resource::upstream define:' do
  it 'runs successfully' do
    pp = "
    class { 'nginx': }
    nginx::resource::upstream { 'production':
      ensure             => present,
      ip_hash            => true,
      keepalive          => 16,
      member_defaults    => {
        max_conns    => 20,
        max_fails    => 20,
        fail_timeout => '20s',
      },
      members            => {
        'appserver_01' => {
          server       => '10.10.10.1',
          port         => 80,
          weight       => 2,
          max_conns    => 10,
          max_fails    => 10,
          fail_timeout => '10s',
          comment      => 'Appserver 01',
        },
        'appserver_02' => {
          server       => '10.10.10.2',
          port         => 80,
          weight       => 3,
          max_conns    => 15,
          max_fails    => 15,
          fail_timeout => '15s',
          comment      => 'Appserver 02',
        },
        'appserver_03' => {
          server       => '10.10.10.3',
          port         => 80,
          backup       => true,
          comment      => 'Appserver 03',
        },
        'appserver_v6' => {
          server       => '2001:db8::6',
          port         => 80,
          comment      => 'Appserver with IPv6 address',
        },
      },
      zone               => 'production 64k',
    }
    nginx::resource::upstream { 'socket':
      ensure             => present,
      member_defaults    => {
        max_conns    => 20,
        max_fails    => 20,
        fail_timeout => '20s',
      },
      members            => {
        'socket_01' => {
          server => 'unix:/var/run/socket_01.sock',
        },
        'socket_02' => {
          server => 'unix:/var/run/socket_02.sock',
        },
      },
      zone               => 'socket 64k',
    }

    nginx::resource::server { 'www.puppetlabs.com':
      ensure => present,
      proxy  => 'http://production',
    }
    nginx::resource::server { 'socket.puppetlabs.com':
      ensure => present,
      proxy  => 'http://socket',
    }
    "
    apply_manifest(pp, catch_failures: true)
  end

  describe file('/etc/nginx/conf.d/production-upstream.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain 'upstream production {' }
    it { is_expected.to contain '  server 10.10.10.1:80 weight=2 max_conns=10 max_fails=10 fail_timeout=10s; # Appserver 01' }
    it { is_expected.to contain '  server 10.10.10.2:80 weight=3 max_conns=15 max_fails=15 fail_timeout=15s; # Appserver 02' }
    it { is_expected.to contain '  server 10.10.10.3:80 max_conns=20 max_fails=20 fail_timeout=20s backup; # Appserver 03' }
    it { is_expected.to contain '  server [2001:db8::6]:80 max_conns=20 max_fails=20 fail_timeout=20s; # Appserver with IPv6 address' }
    it { is_expected.to contain '  ip_hash;' }
    it { is_expected.to contain '  zone production 64k;' }
    it { is_expected.to contain '  keepalive 16;' }
  end
  describe file('/etc/nginx/sites-available/www.puppetlabs.com.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain '    proxy_pass            http://production;' }
  end

  describe file('/etc/nginx/conf.d/socket-upstream.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain 'upstream socket {' }
    it { is_expected.to contain '  server unix:/var/run/socket_01.sock max_conns=20 max_fails=20 fail_timeout=20s;' }
    it { is_expected.to contain '  server unix:/var/run/socket_02.sock max_conns=20 max_fails=20 fail_timeout=20s;' }
    it { is_expected.to contain '  zone socket 64k;' }
  end
  describe file('/etc/nginx/sites-available/socket.puppetlabs.com.conf') do
    it { is_expected.to be_file }
    it { is_expected.to contain '# MANAGED BY PUPPET' }
    it { is_expected.to contain '    proxy_pass            http://socket;' }
  end

  describe service('nginx') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe port(80) do
    it { is_expected.to be_listening }
  end
end
