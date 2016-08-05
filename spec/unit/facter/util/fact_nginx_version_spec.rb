require 'spec_helper'

describe Facter::Util::Fact do
  before { Facter.clear }

  context 'with current version output format' do
    before do
      Facter::Util::Resolution.stubs(:which).with('nginx').returns(true)
      Facter::Util::Resolution.stubs(:exec).with('nginx -v 2>&1').returns('nginx version: nginx/1.8.1')
    end
    it { expect(Facter.fact(:nginx_version).value).to eq('1.8.1') }
  end
  context 'with old version output format' do
    before do
      Facter::Util::Resolution.stubs(:which).with('nginx').returns(true)
      Facter::Util::Resolution.stubs(:exec).with('nginx -v 2>&1').returns('nginx: nginx version: nginx/0.7.0')
    end
    it { expect(Facter.fact(:nginx_version).value).to eq('0.7.0') }
  end
end
