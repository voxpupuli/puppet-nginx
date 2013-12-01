require 'spec_helper_system'

describe "nginx::resource::vhost define:" do
  context 'new vhost on port 80' do
    it 'should configure a nginx vhost' do

      pp = "
      class { 'nginx': }
      nginx::resource::vhost { 'www.puppetlabs.com':
        ensure   => present,
        www_root => '/var/www/www.puppetlabs.com',
      }
      "

      puppet_apply(pp) do |r|
        [0,2].should include r.exit_code
        r.refresh
        r.stderr.should be_empty
        r.exit_code.should be_zero
      end
    end
  end

  describe file('/etc/nginx/conf.d/vhost_autogen.conf') do
   it { should be_file }
   it { should contain "www.puppetlabs.com" }
  end

end
