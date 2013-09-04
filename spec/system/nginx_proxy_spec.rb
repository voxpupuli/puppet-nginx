require 'spec_helper_system'

describe "nginx::resource::upstream define:" do
  context 'should run successfully' do

    pp = "
    class { 'nginx': }
    nginx::resource::upstream { 'puppet_rack_app':
      ensure  => present,
      members => [
        'localhost:3000',
        'localhost:3001',
        'localhost:3002',
      ],
    }
    nginx::resource::vhost { 'rack.puppetlabs.com':
      ensure => present,
      proxy  => 'http://puppet_rack_app',
    }
    "

    context puppet_apply(pp) do
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end

  describe file('/etc/nginx/conf.d/puppet_rack_app-upstream.conf') do
   it { should be_file }
   it { should contain "server     localhost:3000" }
   it { should contain "server     localhost:3001" }
   it { should contain "server     localhost:3002" }
   it { should_not contain "server     localhost:3003" }
  end

  describe file('/etc/nginx/conf.d/vhost_autogen.conf') do
    it { should be_file }
    it { should contain "proxy_pass          http://puppet_rack_app;" }
  end

end
