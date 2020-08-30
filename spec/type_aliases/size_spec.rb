require 'spec_helper'

describe 'Nginx::Size' do
  it { is_expected.to allow_value('1024k') }
  it { is_expected.to allow_value('1024K') }
  it { is_expected.to allow_value('1m') }
  it { is_expected.to allow_value('1M') }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value(1) }
  it { is_expected.not_to allow_value(1024) }
  it { is_expected.not_to allow_value('') }
  it { is_expected.not_to allow_value('0.1k') }
  it { is_expected.not_to allow_value('0.1K') }
  it { is_expected.not_to allow_value('0.1m') }
  it { is_expected.not_to allow_value('0.1M') }
  it { is_expected.not_to allow_value('1g') }
  it { is_expected.not_to allow_value('1G') }
end
