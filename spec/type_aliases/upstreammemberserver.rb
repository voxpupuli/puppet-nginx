require 'spec_helper'

describe 'Nginx::UpstreamMemberServer' do
  it { is_expected.to allow_value('10.10.10.10') }
  it { is_expected.to allow_value('backend.example.com') }
  it { is_expected.to allow_value('unix:/tmp/backend') }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value('') }
  it { is_expected.not_to allow_value(1) }
  it { is_expected.not_to allow_value('10.10.10.10:80') }
  it { is_expected.not_to allow_value('backend.example.com:80') }
  it { is_expected.not_to allow_value('unix:/tmp/backend:80') }
  it { is_expected.not_to allow_value('linux:/tmp/backend') }
end
