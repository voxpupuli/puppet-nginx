require 'spec_helper'

describe 'nginx' do
  shared_examples "a Linux OS" do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('nginx') }
    it { is_expected.to contain_nginx__service__init.that_subscribes_to('Class[nginx::config]') }
  end

  context "Debian OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'Debian',
          :osfamily        => 'Debian',
          :lsbdistcodename => 'precise',
          :lsbdistid       => 'Debian',
        }
      end

      it { is_expected.to contain_nginx__package__debian.that_comes_before('Class[nginx::config]') }
    end
  end

  context "RedHat OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'RedHat',
          :osfamily        => 'RedHat',
        }
      end

      it { is_expected.to contain_nginx__package__redhat.that_comes_before('Class[nginx::config]') }
    end
  end

  context "SuSE OS" do
    it_behaves_like "a Linux OS" do
      let :facts do
        {
          :operatingsystem => 'SuSE',
          :osfamily        => 'SuSE',
        }
      end

      it { is_expected.to contain_nginx__package__suse.that_comes_before('Class[nginx::config]') }
    end
  end
end
