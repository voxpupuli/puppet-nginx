require 'spec_helper'

describe Facter::Util::Fact do
  before { Facter.clear }

  describe 'nginx_version' do

    before do
      Facter::Util::Resolution.stubs(:exec)
    end

    context 'neither nginx or openresty in path' do
      before do
        Facter::Util::Resolution.stubs(:which).with('nginx').returns(false)
        Facter::Util::Resolution.stubs(:which).with('openresty').returns(false)
      end
      it { expect(Facter.fact(:nginx_version).value).to eq(nil) }
    end
    context 'nginx in path' do
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
    context 'openresty in path' do
      context 'with current version output format' do
        before do
          Facter::Util::Resolution.stubs(:which).with('nginx').returns(false)
          Facter::Util::Resolution.stubs(:which).with('openresty').returns(true)
          Facter::Util::Resolution.stubs(:exec).with('openresty -v 2>&1').returns('nginx version: openresty/1.11.2.1')
        end
        it { expect(Facter.fact(:nginx_version).value).to eq('1.11.2.1') }
      end
      context 'with old version output format' do # rubocop:disable RSpec/EmptyExampleGroup
      # Openresty never used the old format as far as I can find, no point testing
      end
    end
  end
end
