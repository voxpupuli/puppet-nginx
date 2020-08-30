require 'spec_helper'

describe 'Nginx::Listen::V4' do
  it { is_expected.to allow_value('*') }
  it { is_expected.to allow_value('127.0.0.1') }
  it { is_expected.to allow_value('192.0.2.1') }
  it { is_expected.to allow_value(['198.51.100.1', '203.0.113.1']) }
  it { is_expected.not_to allow_value('192.0.2.1/24') }
  it { is_expected.not_to allow_value('::') }
  it { is_expected.not_to allow_value('2001:db8::1') }
end
