require 'spec_helper'

describe 'Nginx::DebugConnection' do
  it { is_expected.to allow_value('127.0.0.1') }
  it { is_expected.to allow_value('localhost') }
  it { is_expected.to allow_value('192.0.2.0/24') }
  it { is_expected.to allow_value('::1') }
  it { is_expected.to allow_value('2001:0db8::/32') }
  it { is_expected.to allow_value('unix:') }
end
