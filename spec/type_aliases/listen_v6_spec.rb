require 'spec_helper'

describe 'Nginx::Listen::V6' do
  it { is_expected.to allow_value('::') }
  it { is_expected.to allow_value('::1') }
  it { is_expected.to allow_value('2001:db8::1') }
  it { is_expected.to allow_value(['2001:db8::1', '2001:0db8:ffff:ffff:ffff:ffff:ffff:ffff']) }
  it { is_expected.not_to allow_value('2001:db8::/64') }
  it { is_expected.not_to allow_value('192.0.2.1') }
  it { is_expected.not_to allow_value('*') }
end
