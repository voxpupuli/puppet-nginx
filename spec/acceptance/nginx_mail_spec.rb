require 'spec_helper_acceptance'

describe "nginx::resource::mailhost define:" do
  it 'should run successfully' do

    pp = "
    class { 'nginx':
      mail => true,
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

    apply_manifest(pp, :catch_failures => true)
  end

  describe file('/etc/nginx/conf.mail.d/domain1.example.conf') do
   it { is_expected.to be_file }
   it { is_expected.to contain "auth_http             localhost/cgi-bin/auth;" }
  end

end
