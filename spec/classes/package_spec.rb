require 'spec_helper'

describe 'nginx::package::redhat' do

  shared_examples 'RedHat' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'RedHat' }}

    context "using defaults" do
      it { is_expected.to contain_package('nginx') }
      it { is_expected.to contain_yumrepo('nginx-release').with(
        'baseurl'  => 'http://nginx.org/packages/rhel/6/$basearch/',
        'descr'    => 'nginx repo',
        'enabled'  => '1',
        'gpgcheck' => '1',
        'priority' => '1',
        'gpgkey'   => 'http://nginx.org/keys/nginx_signing.key'
      )}
      it { is_expected.to contain_file('/etc/yum.repos.d/nginx-release.repo') }
    end

    context "manage_repo => false" do
      let(:params) {{ :manage_repo => false }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.not_to contain_yumrepo('nginx-release') }
      it { is_expected.not_to contain_file('/etc/yum.repos.d/nginx-release.repo') }
    end

    context "lsbmajdistrelease = 5" do
      let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'RedHat', :lsbmajdistrelease => 5 }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.to contain_yumrepo('nginx-release').with(
        'baseurl'  => 'http://nginx.org/packages/rhel/5/$basearch/'
      )}
      it { is_expected.to contain_file('/etc/yum.repos.d/nginx-release.repo') }
    end

    context 'fedora' do
      # fedora is identical to the rest of osfamily RedHat except for not
      # including nginx-release
      let(:facts) {{ :operatingsystem => 'Fedora', :osfamily => 'RedHat', :lsbmajdistrelease => 6 }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.not_to contain_yumrepo('nginx-release') }
      it { is_expected.not_to contain_file('/etc/yum.repos.d/nginx-release.repo') }
    end

    describe 'installs the requested package version' do
      let(:facts) {{ :operatingsystem => 'RedHat', :osfamily => 'RedHat' }}
      let(:params) {{ :package_ensure => '3.0.0' }}

      it 'installs 3.0.0 exactly' do
        is_expected.to contain_package('nginx').with({
          'ensure' => '3.0.0'
        })
      end
    end
  end

  context 'RedHat' do
    it_behaves_like 'RedHat', 'CentOS'
    it_behaves_like 'RedHat', 'OracleLinux'
    it_behaves_like 'RedHat', 'RedHat'
    it_behaves_like 'RedHat', 'Scientific'
    it_behaves_like 'RedHat', 'Amazon'
  end

  context 'amazon with facter < 1.7.2' do
    let(:facts) {{ :operatingsystem => 'Amazon', :osfamily => 'Linux' }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.to contain_yumrepo('nginx-release').with(
        'baseurl'  => 'http://nginx.org/packages/rhel/6/$basearch/',
        'descr'    => 'nginx repo',
        'enabled'  => '1',
        'gpgcheck' => '1',
        'priority' => '1',
        'gpgkey'   => 'http://nginx.org/keys/nginx_signing.key'
      )}
      it { is_expected.to contain_file('/etc/yum.repos.d/nginx-release.repo') }
  end
end

describe 'nginx::package::debian' do
  shared_examples 'Debian' do |operatingsystem, lsbdistcodename, lsbdistid|
    let(:facts) {{
      :operatingsystem => operatingsystem,
      :osfamily        => 'Debian',
      :lsbdistcodename => lsbdistcodename,
      :lsbdistid       => lsbdistid
    }}

    context "using defaults" do
      it { is_expected.to contain_package('nginx') }
      it { is_expected.not_to contain_package('passenger') }
      it { is_expected.to contain_apt__source('nginx').with(
        'location'   => "http://nginx.org/packages/#{operatingsystem.downcase}",
        'repos'      => 'nginx',
        'key'        => '7BD9BF62',
        'key_source' => 'http://nginx.org/keys/nginx_signing.key'
      )}
    end

    context "package_source => 'passenger'" do
      let(:params) {{ :package_source => 'passenger' }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.to contain_package('passenger') }
      it { is_expected.to contain_apt__source('nginx').with(
        'location'   => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
        'repos'      => "main",
        'key'        => '561F9B9CAC40B2F7',
        'key_source' => 'https://oss-binaries.phusionpassenger.com/auto-software-signing-gpg-key.txt'
      )}
    end

    context "manage_repo => false" do
      let(:params) {{ :manage_repo => false }}
      it { is_expected.to contain_package('nginx') }
      it { is_expected.not_to contain_apt__source('nginx') }
      it { is_expected.not_to contain_package('passenger') }
    end
  end

  context 'Debian' do
    it_behaves_like 'Debian', 'Debian', 'wheezy', 'Debian'
    it_behaves_like 'Debian', 'Ubuntu', 'precise', 'Ubuntu'
  end
end

describe 'nginx::package::suse' do
  shared_examples 'SuSE' do |operatingsystem|
    let(:facts) {{ :operatingsystem => operatingsystem, :osfamily => 'SuSE'}}
    [
      'nginx',
    ].each do |package|
      it { is_expected.to contain_package("#{package}") }
    end
  end

  context 'SuSE' do
    it_behaves_like 'SuSE', 'OpenSuSE'
    it_behaves_like 'SuSE', 'SuSE'
  end
end
