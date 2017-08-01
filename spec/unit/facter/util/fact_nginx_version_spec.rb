require 'spec_helper'

describe Facter::Util::Fact do
  before { Facter.clear }

  context 'neither nginx or openresty in path' do
    before do
      allow(Facter::Util::Resolution).to receive(:which).with('nginx') { false }
      allow(Facter::Util::Resolution).to receive(:which).with('openresty') { false }
    end
    it { expect(Facter.fact(:nginx_version).value).to eq(nil) }
  end
  context 'nginx' do
    context 'with current version output format' do
      before do
        allow(Facter::Util::Resolution).to(receive(:which).with('nginx').twice) { true }
        allow(Facter::Util::Resolution).to receive(:exec).with('nginx -v 2>&1') { 'nginx version: nginx/1.8.1' }
      end
      it { expect(Facter.fact(:nginx_version).value).to eq('1.8.1') }
    end
    context 'with old version output format' do
      before do
        allow(Facter::Util::Resolution).to(receive(:which).with('nginx').twice) { true }
        allow(Facter::Util::Resolution).to receive(:exec).with('nginx -v 2>&1') { 'nginx: nginx version: nginx/0.7.0' }
      end
      it { expect(Facter.fact(:nginx_version).value).to eq('0.7.0') }
    end
  end
  context 'openresty' do
    context 'with current version output format' do
      before do
        allow(Facter::Util::Resolution).to(receive(:which).with('nginx').twice) { false }
        allow(Facter::Util::Resolution).to receive(:which).with('openresty') { true }
        allow(Facter::Util::Resolution).to receive(:exec).with('openresty -v 2>&1') { 'nginx version: openresty/1.11.2.1' }
      end
      it { expect(Facter.fact(:nginx_version).value).to eq('1.11.2.1') }
    end
    context 'with old version output format' do # rubocop:disable RSpec/EmptyExampleGroup
      # Openresty never used the old format as far as I can find, no point testing
    end
  end
end
