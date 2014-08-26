require 'spec_helper'

describe 'nginx::params' do
  context "On a Debian OS" do
    let :facts do {
      :osfamily        => 'debian',
      :operatingsystem => 'debian',
    } end

    it { is_expected.to contain_nginx__params }
    it { is_expected.to have_class_count(1) }    #only nginx::params itself
    it { is_expected.to have_resource_count(0) } #params class should never declare resources

  end
end
