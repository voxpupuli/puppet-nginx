require 'spec_helper'

describe 'Nginx::UpstreamCustomParameters' do
  it { is_expected.to allow_value('key' => 'value') }
  it { is_expected.to allow_value('key' => 20) }
  it { is_expected.to allow_value('key' => %w[value1 value2]) }
  it { is_expected.to allow_value('key' => %w[20 21]) }
  it { is_expected.to allow_value('key' => %w[value1 20]) }
  it { is_expected.to allow_value('key' => { 'subkey' => 'value' }) }
  it { is_expected.to allow_value('key' => { 'subkey' => 20 }) }
  it { is_expected.to allow_value('key' => { 'subkey' => %w[subvalue1 subvalue2] }) }
  it { is_expected.to allow_value('key' => { 'subkey' => %w[20 21] }) }
  it { is_expected.to allow_value('key' => { 'subkey' => %w[subvalue1 20] }) }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value(20 => 'value') }
  it { is_expected.not_to allow_value('key' => '') }
  it { is_expected.not_to allow_value('key' => { '' => 'value' }) }
  it { is_expected.not_to allow_value('key' => { 20 => 'value' }) }
  it { is_expected.not_to allow_value('key' => { 'subkey' => { 'subsubkey' => 'value' } }) }
  it { is_expected.not_to allow_value('key' => { 'subkey' => { 'subsubkey' => 20 } }) }
  it { is_expected.not_to allow_value('key' => { 'subkey' => { 'subsubkey' => %w[subvalue1 subvalue2] } }) }
  it { is_expected.not_to allow_value('key' => { 'subkey' => { 'subsubkey' => %w[20 21] } }) }
  it { is_expected.not_to allow_value('key' => { 'subkey' => { 'subsubkey' => %w[subvalue1 20] } }) }
end
