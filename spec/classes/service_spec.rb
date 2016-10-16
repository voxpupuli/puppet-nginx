require 'spec_helper'
describe 'nginx::service' do
  let :params do
    {
      service_ensure: 'running',
      service_name: 'nginx',
      service_manage: true
    }
  end

  context 'using default parameters' do
    it do
      is_expected.to contain_service('nginx').with(
        ensure: 'running',
        enable: true,
        hasstatus: true,
        hasrestart: true
      )
    end

    it { is_expected.to contain_service('nginx').without_restart }
  end

  context "when service_restart => 'a restart command'" do
    let :params do
      {
        service_restart: 'a restart command',
        service_ensure: 'running',
        service_name: 'nginx'
      }
    end
    it { is_expected.to contain_service('nginx').with_restart('a restart command') }
  end

  describe "when service_name => 'nginx14" do
    let :params do
      {
        service_name: 'nginx14'
      }
    end
    it { is_expected.to contain_service('nginx').with_name('nginx14') }
  end

  describe 'when service_manage => false' do
    let :params do
      {
        service_manage: false
      }
    end
    it { is_expected.not_to contain_service('nginx') }
  end
end
