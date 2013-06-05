require 'spec_helper'

describe 'nginx::package' do

  shared_examples 'redhat' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem }}
    it { should contain_package('nginx') }
    it { should contain_package('GeoIP') }
    it { should contain_package('gd') }
    it { should contain_package('libXpm') }
    it { should contain_package('libxslt') }
    it { should contain_yumrepo('nginx-release').with_enabled('1') }
  end

  shared_examples 'debian' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem }}
    it { should contain_file('/etc/apt/sources.list.d/nginx.list') }
  end

  shared_examples 'suse' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem }}
    it { should contain_package('nginx-0.8') }
    it { should contain_package('apache2') }
    it { should contain_package('apache2-itk') }
    it { should contain_package('apache2-utils') }
    it { should contain_package('gd') }
  end


  context 'RedHat' do
    it_behaves_like 'redhat', 'centos'
    it_behaves_like 'redhat', 'fedora'
    it_behaves_like 'redhat', 'rhel'
    it_behaves_like 'redhat', 'redhat'
    it_behaves_like 'redhat', 'scientific'
  end

  context 'amazon' do
    let(:facts) {{ :operatingsystem => 'amazon' }}
    it { should contain_package('nginx') }
  end

  context 'debian' do
    it_behaves_like 'debian', 'debian'
    it_behaves_like 'debian', 'ubuntu'
  end

  context 'suse' do
    it_behaves_like 'suse', 'opensuse'
    it_behaves_like 'suse', 'suse'
  end

  context 'other' do
    let(:facts) {{ :operatingsystem => 'xxx' }}
    it { expect { subject }.to raise_error(Puppet::Error, /Module nginx is not supported on xxx/) }
  end
end
