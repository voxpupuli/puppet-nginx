require 'spec_helper'

describe 'nginx::params' do
  context "On a Debian OS" do
    let :facts do {
      :osfamily        => 'debian',
      :operatingsystem => 'debian',
      :kernel          => 'Linux',
    } end

    it { should contain_nginx__params }

    # There are 4 resources in this class currently
    # there should not be any more resources because it is a params class
    # The resources are class[nginx::params], class[main], class[settings], stage[main]
    it "Should not contain any resources" do
      subject.resources.size.should == 4
    end
  end
end
