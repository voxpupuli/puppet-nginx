require 'spec_helper'

describe 'nginx' do

  shared_examples 'linux' do |operatingsystem, lsbdistcodename, user|
    let(:facts) {{ :kernel => 'linux',
      :operatingsystem => operatingsystem,
      :osfamily => operatingsystem,
      :lsbdistcodename => lsbdistcodename }}

    it { should contain_service('nginx').with(
        :ensure => 'running',
        :enable => true
    ) }

    it { should contain_file('/var/nginx/client_body_temp').with_owner(user) }
  end


  context 'redhat' do
    it_behaves_like 'linux', 'redhat', '6.4', 'nginx'
  end

  context 'debian' do
    it_behaves_like 'linux', 'debian', 'Wheezy', 'www-data'
  end

  describe 'installs the requested package version' do
    let(:facts) {{ :kernel => 'linux', :operatingsystem => 'redhat', :osfamily => 'redhat' }}
    let(:params) {{ :package_ensure => '3.0.0' }}

    it 'installs 3.0.0 exactly' do
      should contain_package('nginx').with({
        'ensure' => '3.0.0'
      })
    end
  end

end
