require 'spec_helper'

describe 'nginx::resource::snippet' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :title do
        'some_snippet'
      end

      let :pre_condition do
        'include nginx'
      end

      describe 'basic snippet' do
        let :params do
          {
            raw_content: 'this is a test'
          }
        end

        it { is_expected.to contain_concat__fragment('snippet-some_snippet-header').with_target("/etc/nginx/snippets/#{title}.conf").with_content(%r{this is a test}) }
        it { is_expected.to contain_concat('/etc/nginx/snippets/some_snippet.conf') }
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
