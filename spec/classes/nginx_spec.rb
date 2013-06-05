require 'spec_helper'

describe 'nginx' do

  shared_examples 'linux' do |operatingsystem, user|
    let(:facts) {{ :kernel => 'linux', :operatingsystem => operatingsystem }}

    it { should contain_service('nginx').with(
        :ensure => 'running',
        :enable => true
    ) }

    it { should contain_file('/var/nginx/client_body_temp').with_owner(user) }
  end


  context 'redhat' do
    it_behaves_like 'linux', 'redhat', 'nginx'
  end

  context 'debian' do
    it_behaves_like 'linux', 'debian', 'www-data'
  end

end
