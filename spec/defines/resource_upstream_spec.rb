require 'spec_helper'

describe 'nginx::resource::upstream' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :title do
        'upstream-test'
      end

      let :default_params do
        {
          members: ['test']
        }
      end

      let :pre_condition do
        [
          'include ::nginx'
        ]
      end

      describe 'os-independent items' do
        describe 'basic assumptions' do
          let(:params) { default_params }

          it { is_expected.to contain_concat("/etc/nginx/conf.d/#{title}-upstream.conf").that_requires('File[/etc/nginx/conf.d]') }
          it { is_expected.to contain_concat__fragment("#{title}_upstream_header").with_content(%r{upstream #{title}}) }

          it do
            is_expected.to contain_concat__fragment("#{title}_upstream_header").with(
              'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
              'order'  => 10
            )
          end

          it do
            is_expected.to contain_concat__fragment("#{title}_upstream_members").with(
              'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
              'order'  => 50
            )
          end

          it do
            is_expected.to contain_concat__fragment("#{title}_upstream_footer").with(
              'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
              'order'  => 90
            ).with_content("}\n")
          end
        end

        describe 'upstream.conf template content' do
          [
            {
              title: 'should contain ordered prepended directives',
              attr: 'upstream_cfg_prepend',
              fragment: 'header',
              value: {
                'test3'     => 'test value 3',
                'test6'     => { 'subkey1' => %w[subvalue1 subvalue2] },
                'keepalive' => 'keepalive 1',
                'test2'     => 'test value 2',
                'test5'     => { 'subkey1' => 'subvalue1' },
                'test4'     => ['test value 1', 'test value 2']
              },
              match: [
                '  test2 test value 2;',
                '  test3 test value 3;',
                '  test4 test value 1;',
                '  test4 test value 2;',
                '  test5 subkey1 subvalue1;',
                '  test6 subkey1 subvalue1;',
                '  test6 subkey1 subvalue2;',
                '  keepalive keepalive 1;'
              ]
            },
            {
              title: 'should set server',
              attr: 'members',
              fragment: 'members',
              value: %w[test3 test1 test2],
              match: [
                '  server     test3  fail_timeout=10s;',
                '  server     test1  fail_timeout=10s;',
                '  server     test2  fail_timeout=10s;'
              ]
            },
            {
              title: 'should contain ordered appended directives',
              attr: 'upstream_cfg_append',
              fragment: 'footer',
              value: {
                'test3' => 'test value 3',
                'test6' => { 'subkey1' => %w[subvalue1 subvalue2] },
                'keepalive' => 'keepalive 1',
                'test2' => 'test value 2',
                'test5' => { 'subkey1' => 'subvalue1' },
                'test4' => ['test value 1', 'test value 2']
              },
              match: [
                '  test2 test value 2;',
                '  test3 test value 3;',
                '  test4 test value 1;',
                '  test4 test value 2;',
                '  test5 subkey1 subvalue1;',
                '  test6 subkey1 subvalue1;',
                '  test6 subkey1 subvalue2;',
                '  keepalive keepalive 1;'
              ]
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_concat("/etc/nginx/conf.d/#{title}-upstream.conf").with_mode('0644') }
              it { is_expected.to contain_concat__fragment("#{title}_upstream_#{param[:fragment]}") }
              it param[:title] do
                lines = catalogue.resource('concat::fragment', "#{title}_upstream_#{param[:fragment]}").send(:parameters)[:content].split("\n")
                expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}_upstream_#{param[:fragment]}").without_content(item)
                end
              end
            end
          end

          context 'when ensure => absent' do
            let :params do
              default_params.merge(
                ensure: 'absent'
              )
            end

            it { is_expected.to contain_concat("/etc/nginx/conf.d/#{title}-upstream.conf").with_ensure('absent') }
          end
        end
      end
    end
  end
end
