require 'spec_helper_system'

describe "nginx::resource::mailhost define:" do
  context 'should run successfully' do

    pp = "
    class { 'nginx':
      mail => true,
    }
    nginx::resource::vhost { 'www.puppetlabs.com':
      ensure   => present,
      www_root => '/var/www/www.puppetlabs.com',
    }
    nginx::resource::mailhost { 'domain1.example':
      ensure      => present,
      auth_http   => 'localhost/cgi-bin/auth',
      protocol    => 'smtp',
      listen_port => 587,
      ssl_port    => 465,
      xclient     => 'off',
    }
    "

    context puppet_apply(pp) do
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      # Not until deprecated variables fixed.
      #its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end

  describe file('/etc/nginx/conf.mail.d/vhost_autogen.conf') do
   it { should be_file }
   it { should contain "auth_http             localhost/cgi-bin/auth;" }
  end

end
