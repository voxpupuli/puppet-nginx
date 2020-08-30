require 'spec_helper'

describe 'Nginx::Headers' do
  it { is_expected.to allow_value({ 'header3' => { '' => '\'test value 3\' tv3' }, 'header2' => { 'test value 2' => 'tv2' }, 'header1' => 'test value 1' }) }
  it { is_expected.to allow_value({ 'Content-type' => 'application/html' }) }
  it { is_expected.not_to allow_value({ 'Content-Type' => '' }) }
  it { is_expected.not_to allow_value({ '' => 'application/html' }) }
end
