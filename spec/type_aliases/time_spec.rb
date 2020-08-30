require 'spec_helper'

describe 'Nginx::Time' do
  it { is_expected.to allow_value('10ms') }
  it { is_expected.to allow_value('10s') }
  it { is_expected.to allow_value('10m') }
  it { is_expected.to allow_value('10h') }
  it { is_expected.to allow_value('1d') }
  it { is_expected.to allow_value('1M') }
  it { is_expected.to allow_value('1y') }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value(1) }
  it { is_expected.not_to allow_value(10) }
  it { is_expected.not_to allow_value('') }
  it { is_expected.not_to allow_value('10S') }
  it { is_expected.not_to allow_value('10.0s') }
  it { is_expected.not_to allow_value('10,0s') }
end
