require 'spec_helper'

describe 'nginx::package' do

  shared_examples 'redhat' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'RedHat' }}
    it { should contain_package('nginx') }
    it { should contain_package('gd') }
    it { should contain_package('libXpm') }
    it { should contain_package('libxslt') }
    it { should contain_yumrepo('nginx-release').with_enabled('1') }
  end

  shared_examples 'debian' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'Debian'}}
    it { should contain_file('/etc/apt/sources.list.d/nginx.list') }
  end

  shared_examples 'suse' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'Suse'}}
    it { should contain_package('nginx-0.8') }
    it { should contain_package('apache2') }
    it { should contain_package('apache2-itk') }
    it { should contain_package('apache2-utils') }
    it { should contain_package('gd') }
  end


  context 'redhat' do
    it_behaves_like 'redhat', 'centos'
    it_behaves_like 'redhat', 'rhel'
    it_behaves_like 'redhat', 'redhat'
    it_behaves_like 'redhat', 'scientific'
    it_behaves_like 'redhat', 'amazon'
  end

  context 'debian' do
    it_behaves_like 'debian', 'debian'
    it_behaves_like 'debian', 'ubuntu'
  end

  context 'suse' do
    it_behaves_like 'suse', 'opensuse'
    it_behaves_like 'suse', 'suse'
  end

  context 'amazon with facter < 1.7.2' do
    let(:facts) {{ :operatingsystem => 'Amazon', :osfamily => 'Linux' }}
    it { should contain_class('nginx::package::redhat') }
  end

  context 'fedora' do
    # fedora is identical to the rest of osfamily RedHat except for not
    # including nginx-release
    let(:facts) {{ :operatingsystem => 'Fedora', :osfamily => 'RedHat' }}
    it { should contain_package('nginx') }
    it { should contain_package('gd') }
    it { should contain_package('libXpm') }
    it { should contain_package('libxslt') }
    it { should_not contain_yumrepo('nginx-release') }
  end

  context 'other' do
    let(:facts) {{ :operatingsystem => 'xxx' }}
    it { expect { subject }.to raise_error(Puppet::Error, /Module nginx is not supported on xxx/) }
  end
end
