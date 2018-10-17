require 'spec_helper'

describe 'Nginx::Resolver' do
  describe 'accepts valid options' do
    [
      { 'addresses' => ['localhost'] },
      { 'addresses' => [['localhost', 443]] },
      { 'addresses' => ['127.0.0.1', ['localhost', 443]] },
      { 'addresses' => ['localhost'], 'ipv6' => 'on' },
      { 'addresses' => ['localhost'], 'valid' => '30s' },
      { 'addresses' => ['localhost'], 'valid' => '30s', 'ipv6' => 'on' }
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'rejects invalid options' do
    [
      '127.0.0.1',
      {},
      { 'ipv6' => 'other' },
      { 'addresses' => [['localhost']] },
      { 'addresses' => ['localhost'], 'ipv6' => 'other' },
      { 'addresses' => ['localhost'], 'valid' => 'yes' },
      :undef
    ].each do |value|
      describe value.inspect do
        it { is_expected.not_to allow_value(value) }
      end
    end
  end
end
