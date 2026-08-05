# frozen_string_literal: true

require 'spec_helper'

describe 'nginx::resource::geo' do
  on_supported_os.each do |os, facts|
    context "on #{os} with Facter #{facts[:facterversion]} and Puppet #{facts[:puppetversion]}" do
      let(:facts) do
        facts
      end
      let :title do
        'client_network'
      end

      let :pre_condition do
        [
          'include nginx',
        ]
      end

      let :default_params do
        {
          default: 'extra',
          networks: {
            'intra' => ['10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16'],
          },
          proxies: ['1.2.3.4', '4.3.2.1'],
        }
      end

      describe 'os-independent items' do
        let(:pre_condition) do
          <<~PUPPET
          class nginx::service {}
          class nginx {
            $root_group = 'root'
            $conf_dir = '/etc/nginx'
            $global_mode = '0644'

            include nginx::service

            file { [$conf_dir, "${conf_dir}/conf.d"]:
              ensure => directory,
            }
          }
          include nginx
          PUPPET
        end

        describe 'basic assumptions' do
          let(:params) { default_params }

          it { is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").that_requires('File[/etc/nginx/conf.d]') }

          it do
            is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with(
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
              'ensure'  => 'file',
              'content' => %r{geo \$#{title}},
            )
          end
        end

        describe 'geo.conf template content' do
          [
            {
              title: 'should set address',
              attr: 'address',
              value: '$remote_addr',
              match: 'geo \$remote_addr \$client_network {',
            },
            {
              title: 'should set ranges',
              attr: 'ranges',
              value: true,
              match: '  ranges;',
            },
            {
              title: 'should set default',
              attr: 'default',
              value: 'extra',
              match: ['  default extra;'],
            },
            {
              title: 'should contain ordered network directives',
              attr: 'networks',
              value: {
                'intra' => ['10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16'],
              },
              match: [
                '  10.0.0.0/8     intra;',
                '  172.16.0.0/12  intra;',
                '  192.168.0.0/16 intra;',
              ],
            },
            {
              title: 'should set multiple proxies',
              attr: 'proxies',
              value: ['1.2.3.4', '4.3.2.1'],
              match: [
                '  proxy 1.2.3.4;',
                '  proxy 4.3.2.1;',
              ],
            },
            {
              title: 'should set proxy_recursive',
              attr: 'proxy_recursive',
              value: true,
              match: '  proxy_recursive;',
            },
            {
              title: 'should set delete',
              attr: 'delete',
              value: '192.168.0.0/16',
              match: '  delete  192.168.0.0/16;',
            },
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_mode('0644') }

              it param[:title] do
                Array(param[:match]).each do |match_item|
                  is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(Regexp.new(match_item))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").without_content(item)
                end
              end
            end
          end

          context 'when ensure => absent' do
            let :params do
              default_params.merge(
                ensure: 'absent',
              )
            end

            it { is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_ensure('absent') }
          end
        end

        describe 'networks parameter with multiple values' do
          context 'with multiple geo values' do
            let :params do
              {
                default: 'extra',
                networks: {
                  'intra' => ['10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16'],
                  'external' => ['8.8.8.0/24'],
                },
                proxies: ['1.2.3.4'],
              }
            end

            it { is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_mode('0644') }

            it 'contains network directives for all values' do
              is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(%r{10\.0\.0\.0/8\s+intra;})
              is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(%r{172\.16\.0\.0/12\s+intra;})
              is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(%r{192\.168\.0\.0/16\s+intra;})
              is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(%r{8\.8\.8\.0/24\s+external;})
            end
          end

          context 'with empty networks hash' do
            let :params do
              {
                networks: {},
              }
            end

            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf") }
          end

          context 'networks are sorted by IP address' do
            let :params do
              {
                networks: {
                  'external' => ['8.8.8.0/24'],
                  'intra' => ['10.0.0.0/8', '192.168.0.0/16'],
                },
              }
            end

            it 'outputs networks in ascending IP order' do
              # 8.8.8.0 < 10.0.0.0 < 192.168.0.0 numerically
              is_expected.to contain_file("/etc/nginx/conf.d/#{title}-geo.conf").with_content(
                %r{8\.8\.8\.0/24\s+external;.*10\.0\.0\.0/8\s+intra;.*192\.168\.0\.0/16\s+intra;}m,
              )
            end
          end
        end
      end
    end
  end
end
