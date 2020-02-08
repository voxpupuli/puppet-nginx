require 'spec_helper'

describe 'Nginx::UpstreamStickyZone' do
  it { is_expected.to allow_value('live:64k') }
  it { is_expected.to allow_value('live:64K') }
  it { is_expected.to allow_value('stage:1m') }
  it { is_expected.to allow_value('stage:1M') }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value(1) }
  it { is_expected.not_to allow_value(1024) }
  it { is_expected.not_to allow_value('live') }
  it { is_expected.not_to allow_value('stage:') }
  it { is_expected.not_to allow_value('live:64') }
  it { is_expected.not_to allow_value('live 64') }
  it { is_expected.not_to allow_value('stage:64.0') }
  it { is_expected.not_to allow_value('stage 64.0') }
  it { is_expected.not_to allow_value('live:1g') }
  it { is_expected.not_to allow_value('live 1g') }
  it { is_expected.not_to allow_value('stage:1G') }
  it { is_expected.not_to allow_value('stage 1G') }
  it { is_expected.not_to allow_value('live:1.0G') }
  it { is_expected.not_to allow_value('live 1.0G') }
  it { is_expected.not_to allow_value('stage:1.0M') }
  it { is_expected.not_to allow_value('stage 1.0M') }
  it { is_expected.not_to allow_value('live 1024k') }
  it { is_expected.not_to allow_value('stage 1M') }
end
