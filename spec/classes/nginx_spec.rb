require 'spec_helper'

describe 'nginx' do
  let :params do
    {
      :nginx_upstreams => { 'upstream1' => { 'members' => ['localhost:3000']} },
      :nginx_vhosts    => { 'test2.local' => { 'www_root' => '/' } },
      :nginx_locations => { 'test2.local' => { 'vhost' => 'test2.local', 'www_root' => '/'} }
    }
  end

  context "on a Debian OS" do
    let :facts do
      {
        :kernel          => 'linux',
        :operatingsystem => 'Debian',
        :osfamily        => 'Debian',
        :lsbdistcodename => 'precise',
        :concat_basedir  => '/var/lib/puppet/concat',
      }
    end

    it { should contain_nginx__package }
    it { should contain_nginx__config }
    it { should contain_nginx__service }
    it { should include_class("nginx::params") }
    it { should contain_nginx__resource__upstream("upstream1") }
    it { should contain_nginx__resource__vhost("test2.local") }
    it { should contain_nginx__resource__location("test2.local") }
  end

  context "on a RedHat OS" do
    let :facts do
      {
        :kernel          => 'linux',
        :operatingsystem => 'RedHat',
        :osfamily        => 'RedHat',
        :concat_basedir  => '/var/lib/puppet/concat',
      }
    end

    it { should contain_nginx__package }
    it { should contain_nginx__config }
    it { should contain_nginx__service }
    it { should include_class("nginx::params") }
    it { should contain_nginx__resource__upstream("upstream1") }
    it { should contain_nginx__resource__vhost("test2.local") }
    it { should contain_nginx__resource__location("test2.local") }
  end

  context "on a Suse OS" do
    let :facts do
      {
        :kernel          => 'linux',
        :operatingsystem => 'SuSE',
        :osfamily        => 'Suse',
        :concat_basedir  => '/var/lib/puppet/concat',
      }
    end

    it { should contain_nginx__package }
    it { should contain_nginx__config }
    it { should contain_nginx__service }
    it { should include_class("nginx::params") }
    it { should contain_nginx__resource__upstream("upstream1") }
    it { should contain_nginx__resource__vhost("test2.local") }
    it { should contain_nginx__resource__location("test2.local") }
  end
end
