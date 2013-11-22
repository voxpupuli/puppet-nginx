require 'spec_helper'
describe 'nginx::service' do

  let :facts do {
    :osfamily        => 'Debian',
    :operatingsystem => 'debian',
    :kernel          => 'Linux',
  } end

  let :pre_condition do
    [
      'include ::nginx::params',
    ]
  end

  context "using default parameters" do

    it { should contain_exec('rebuild-nginx-vhosts').with(
      :command     => "/bin/cat /tmp/nginx.d/* > /etc/nginx/conf.d/vhost_autogen.conf",
      :refreshonly => true,
      :unless      => "/usr/bin/test ! -f /tmp/nginx.d/*",
      :subscribe   => "File[/tmp/nginx.d]"
    )}

    it { should contain_exec('rebuild-nginx-mailhosts').with(
      :command     => "/bin/cat /tmp/nginx.mail.d/* > /etc/nginx/conf.mail.d/vhost_autogen.conf",
      :refreshonly => true,
      :unless      => "/usr/bin/test ! -f /tmp/nginx.mail.d/*",
      :subscribe   => "File[/tmp/nginx.mail.d]"
    )}

    it { should contain_service('nginx').with(
      :ensure     => 'running',
      :enable     => true,
      :hasstatus  => true,
      :hasrestart => true,
      :subscribe  => ['Exec[rebuild-nginx-vhosts]','Exec[rebuild-nginx-mailhosts]']
    )}

    it { should contain_service('nginx').without_restart }

  end

  describe "when configtest_enable => true" do
    let(:params) {{ :configtest_enable => true }}
    it { should contain_service('nginx').with_restart('/etc/init.d/nginx configtest && /etc/init.d/nginx restart') }

    context "when service_restart => 'a restart command'" do
      let(:params) {{ :configtest_enable => true, :service_restart => 'a restart command' }}
      it { should contain_service('nginx').with_restart('a restart command') }
    end
  end

end
