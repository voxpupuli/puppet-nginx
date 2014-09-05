require 'spec_helper'
describe 'nginx::service' do

  let :facts do {
    :osfamily        => 'Debian',
    :operatingsystem => 'debian',
  } end

  let :params do {
      :configtest_enable => false,
      :service_restart => '/etc/init.d/nginx configtest && /etc/init.d/nginx restart',
      :service_ensure => 'running',
  } end   

  context "using default parameters" do

    it { is_expected.to contain_service('nginx').with(
      :ensure     => 'running',
      :enable     => true,
      :hasstatus  => true,
      :hasrestart => true
    )}

    it { is_expected.to contain_service('nginx').without_restart }

  end

  describe "when configtest_enable => true" do
    let :params do {
      :configtest_enable => true,
      :service_restart   => '/etc/init.d/nginx configtest && /etc/init.d/nginx restart',
      :service_ensure    => 'running',
    } end
    it { is_expected.to contain_service('nginx').with_restart('/etc/init.d/nginx configtest && /etc/init.d/nginx restart') }

    context "when service_restart => 'a restart command'" do
      let :params do {
        :configtest_enable => true,
        :service_restart   => 'a restart command',
        :service_ensure    => 'running',
      } end
      it { is_expected.to contain_service('nginx').with_restart('a restart command') }
    end
  end

end
