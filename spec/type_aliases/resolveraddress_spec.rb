require 'spec_helper'

describe 'Nginx::ResolverAddress' do
  describe 'accepts valid options' do
    [
      'localhost',
      '127.0.0.1',
      '8.8.8.8',
      'www.example.com',
      '::1',
      'FF01::101'
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'rejects invalid options' do
    [
      'localhost:80',
      '1.2.3.4:80',
      '127.0.0.1/32',
      'FF01:0:0:0:0:0:0:101/32',
      :undef
    ].each do |value|
      describe value.inspect do
        it { is_expected.not_to allow_value(value) }
      end
    end
  end
end
