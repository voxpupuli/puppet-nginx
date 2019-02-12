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
          http: {
            context: 'http',
            members: { 'member-http' => {} }
          },
          stream: {
            context: 'stream',
            members: { 'member-stream' => {} }
          }
        }
      end

      let :conf_d_pathes do
        {
          http: '/etc/nginx/conf.d',
          stream: '/etc/nginx/conf.stream.d'
        }
      end

      let :pre_condition do
        [
          'include ::nginx'
        ]
      end

      describe 'os-independent items' do
        ##
        ## check that http is the default
        ##
        describe 'basic assumptions for default upstreams' do
          let(:params) { default_params[:http] }

          it {
            is_expected.to compile.with_all_deps
          }
          it {
            is_expected.to contain_concat("/etc/nginx/conf.d/#{title}-upstream.conf").
              that_requires('File[/etc/nginx/conf.d]')
          }
          it {
            is_expected.to contain_concat__fragment("#{title}_upstream_header").
              with_content(%r{upstream #{title}}).
              with(
                'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
                'order'  => 10
              )
          }
          it {
            is_expected.to contain_concat__fragment("#{title}_upstream_member_#{params[:members].keys[0]}").
              with(
                'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
                'order'  => 40
              )
          }
          it {
            is_expected.to contain_concat__fragment("#{title}_upstream_footer").
              with(
                'target' => "/etc/nginx/conf.d/#{title}-upstream.conf",
                'order'  => 90
              ).
              with_content("}\n")
          }
        end

        ##
        ## check http and stream upstreams
        ##
        %w[http stream].each do |upstreamcontext|
          describe "basic assumptions for #{upstreamcontext} upstreams" do
            let(:params) { default_params[upstreamcontext.to_sym] }
            let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

            it {
              is_expected.to compile.with_all_deps
            }
            it {
              is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                that_requires("File[#{conf_d_path}]")
            }
            it {
              is_expected.to contain_concat__fragment("#{title}_upstream_header").
                with_content(%r{upstream #{title}}).
                with(
                  'target' => "#{conf_d_path}/#{title}-upstream.conf",
                  'order'  => 10
                )
            }
            it {
              is_expected.to contain_concat__fragment("#{title}_upstream_member_#{params[:members].keys[0]}").
                with(
                  'target' => "#{conf_d_path}/#{title}-upstream.conf",
                  'order'  => 40
                )
            }
            it {
              is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                with(
                  'target' => "#{conf_d_path}/#{title}-upstream.conf",
                  'order'  => 90
                ).
                with_content("}\n")
            }
          end

          ##
          ## check the upstream template
          ##
          describe 'upstream.conf template content' do
            ##
            ## check the default
            ##
            context "when only a server is specified in a #{upstreamcontext} upstream" do
              let(:params) { default_params[upstreamcontext.to_sym] }
              let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

              it {
                is_expected.to compile.with_all_deps
              }
              it {
                is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                  with_mode('0644')
              }
              it {
                is_expected.to contain_concat__fragment("#{title}_upstream_header").
                  with_content("# MANAGED BY PUPPET\nupstream #{title} {\n")
              }
              it {
                is_expected.to contain_concat__fragment("#{title}_upstream_member_#{params[:members].keys[0]}").
                  with_content("  server #{params[:members].keys[0]}:80;\n")
              }
              it {
                is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                  with_content("}\n")
              }
            end

            ##
            ## check the upstream parameters
            ##
            [
              {
                value: { hash: '$remote_addr consistent' },
                match: 'hash $remote_addr consistent'
              },
              {
                value: { keepalive: 20 },
                match: 'keepalive 20'
              },
              {
                value: { keepalive_requests: 20 },
                match: 'keepalive_requests 20'
              },
              {
                value: { keepalive_timeout: '20s' },
                match: 'keepalive_timeout 20s'
              },
              {
                value: { least_conn: true },
                match: 'least_conn'
              },
              {
                value: { least_conn: false },
                match: false
              },
              {
                value: { least_time: 'last_byte inflight' },
                match: 'least_time last_byte inflight'
              },
              {
                value: { least_time: 'header inflight' },
                match: 'least_time header inflight',
                fails: { stream: 'The parameter "least_time" does not match the datatype "Nginx::UpstreamLeastTimeStream"' }
              },
              {
                value: { least_time: 'first_byte inflight' },
                match: 'least_time first_byte inflight',
                fails: { http: 'The parameter "least_time" does not match the datatype "Nginx::UpstreamLeastTimeHttp"' }
              },
              {
                value: { ntlm: true },
                match: 'ntlm'
              },
              {
                value: { ntlm: false },
                match: false
              },
              {
                value: { queue_max: 20 },
                match: 'queue 20'
              },
              {
                value: { queue_max: 20, queue_timeout: '20s' },
                match: 'queue 20 timeout=20s'
              },
              {
                value: { random: 'two least_conn' },
                match: 'random two least_conn'
              },
              {
                value: { statefile: '/var/lib/nginx/state/servers.conf' },
                match: 'state /var/lib/nginx/state/servers.conf'
              },
              {
                value: { sticky: { cookie: { name: 'srv_id', expires: '1h', domain: '.example.com', httponly: true, secure: true, path: '/' } } },
                match: 'sticky cookie name=srv_id expires=1h domain=.example.com httponly secure path=/'
              },
              {
                value: { sticky: { route: '$route_cookie $route_uri' } },
                match: 'sticky route $route_cookie $route_uri'
              },
              {
                value: { sticky: { learn: { create: '$upstream_cookie_examplecookie', lookup: '$cookie_examplecookie', zone: 'client_sessions:1m' } } },
                match: 'sticky learn create=$upstream_cookie_examplecookie lookup=$cookie_examplecookie zone=client_sessions:1m'
              },
              {
                value: { zone: 'frontend 1M' },
                match: 'zone frontend 1M'
              },
              {
                value: { zone: 'backend 64k' },
                match: 'zone backend 64k'
              }
            ].each do |upstream_parameter|
              context "when #{upstream_parameter[:value].keys[0]} is set to #{upstream_parameter[:value]} in #{upstreamcontext} upstream" do
                let(:params) { default_params[upstreamcontext.to_sym].merge(upstream_parameter[:value]) }
                let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

                if upstream_parameter.key?(:fails) && upstream_parameter[:fails].key?(upstreamcontext.to_sym)
                  it {
                    is_expected.to raise_error(Puppet::Error, %r{#{upstream_parameter[:fails][upstreamcontext.to_sym]}})
                  }
                  next
                end

                it {
                  is_expected.to compile.with_all_deps
                }
                it {
                  is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                    with_mode('0644')
                }
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_header").
                    with_content("# MANAGED BY PUPPET\nupstream #{title} {\n")
                }
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_member_#{params[:members].keys[0]}").
                    with_content("  server #{params[:members].keys[0]}:80;\n")
                }

                if upstream_parameter[:match] != false
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                      with_content("  #{upstream_parameter[:match]};\n}\n")
                  }
                else
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                      with_content("}\n")
                  }
                end
              end
            end

            ##
            ## check the upstream member parameters
            ##
            [
              {
                value: { unix: { server: 'unix:/tmp/backend3' } },
                match: 'unix:/tmp/backend3;'
              },
              {
                value: { member1: {} },
                match: 'member1:80;'
              },
              {
                value: { member1: { server: '127.0.0.1' } },
                match: '127.0.0.1:80;'
              },
              {
                value: { member1: { server: '127.0.0.1', port: 8080 } },
                match: '127.0.0.1:8080;'
              },
              {
                value: { member1: { server: '2001:db8::1' } },
                match: '[2001:db8::1]:80;'
              },
              {
                value: { member1: { server: '2001:db8::1', port: 8080 } },
                match: '[2001:db8::1]:8080;'
              },
              {
                value: { member1: { weight: 20 } },
                match: 'member1:80 weight=20;'
              },
              {
                value: { member1: { max_conns: 20 } },
                match: 'member1:80 max_conns=20;'
              },
              {
                value: { member1: { max_fails: 20 } },
                match: 'member1:80 max_fails=20;'
              },
              {
                value: { member1: { fail_timeout: '20s' } },
                match: 'member1:80 fail_timeout=20s;'
              },
              {
                value: { member1: { backup: true } },
                match: 'member1:80 backup;'
              },
              {
                value: { member1: { backup: false } },
                match: 'member1:80;'
              },
              {
                value: { member1: { resolve: true } },
                match: 'member1:80 resolve;'
              },
              {
                value: { member1: { resolve: false } },
                match: 'member1:80;'
              },
              {
                value: { member1: { route: 'a' } },
                match: 'member1:80 route=a;',
                fails: { stream: 'The parameter "route" is not available for upstreams with context "stream"' }
              },
              {
                value: { member1: { service: 'member1.backend' } },
                match: 'member1:80 service=member1.backend;'
              },
              {
                value: { member1: { slow_start: '20s' } },
                match: 'member1:80 slow_start=20s;'
              },
              {
                value: { member1: { state: 'drain' } },
                match: 'member1:80 drain;',
                fails: { stream: 'The state "drain" is not available for upstreams with context "stream"' }
              },
              {
                value: { member1: { state: 'down' } },
                match: 'member1:80 down;'
              },
              {
                value: { member1: { params_prepend: 'member=1', weight: 20 } },
                match: 'member1:80 member=1 weight=20;'
              },
              {
                value: { member1: { params_append: 'member=1', weight: 20 } },
                match: 'member1:80 weight=20 member=1;'
              },
              {
                value: { member1: { comment: 'member1' } },
                match: 'member1:80; # member1'
              }
            ].each do |upstream_member_parameter|
              context "when members is set to #{upstream_member_parameter[:value]}" do
                let(:params) { default_params[upstreamcontext.to_sym].merge(members: upstream_member_parameter[:value]) }
                let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

                if upstream_member_parameter.key?(:fails) && upstream_member_parameter[:fails].key?(upstreamcontext.to_sym)
                  it {
                    is_expected.to raise_error(Puppet::Error, %r{#{upstream_member_parameter[:fails][upstreamcontext.to_sym]}})
                  }
                  next
                end

                it {
                  is_expected.to compile.with_all_deps
                }
                it {
                  is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                    with_mode('0644')
                }
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_header").
                    with_content("# MANAGED BY PUPPET\nupstream #{title} {\n")
                }
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_member_#{upstream_member_parameter[:value].keys[0]}").
                    with_content("  server #{upstream_member_parameter[:match]}\n")
                }
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                    with_content("}\n")
                }
              end
            end

            ##
            ## check cfg_prepend and cfg_append
            ##
            [
              {
                parameter: 'cfg_prepend',
                values: {
                  'k2' => 'v2',
                  'k5' => { 'k51' => %w[v51 v52] },
                  'k1' => 'v2',
                  'k4' => { 'k41' => 'v41' },
                  'k3' => %w[v31 v32]
                },
                match: "  k2 v2;\n  k5 k51 v51;\n  k5 k51 v52;\n  k1 v2;\n  k4 k41 v41;\n  k3 v31;\n  k3 v32;\n",
                fragment: 'header'
              },
              {
                parameter: 'cfg_append',
                values: {
                  'k2' => 'v2',
                  'k5' => { 'k51' => %w[v51 v52] },
                  'k1' => 'v2',
                  'k4' => { 'k41' => 'v41' },
                  'k3' => %w[v31 v32]
                },
                match: "  k2 v2;\n  k5 k51 v51;\n  k5 k51 v52;\n  k1 v2;\n  k4 k41 v41;\n  k3 v31;\n  k3 v32;\n",
                fragment: 'footer'
              }
            ].each do |upstream_cfg_extension|
              context "when #{upstream_cfg_extension[:parameter]} is set to #{upstream_cfg_extension[:values]} in #{upstreamcontext} upstream" do
                let(:params) { default_params[upstreamcontext.to_sym].merge(upstream_cfg_extension[:parameter].to_sym => upstream_cfg_extension[:values]) }
                let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

                it {
                  is_expected.to compile.with_all_deps
                }
                it {
                  is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                    with_mode('0644')
                }
                if upstream_cfg_extension[:fragment] == 'header'
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_header").
                      with_content("# MANAGED BY PUPPET\nupstream #{title} {\n#{upstream_cfg_extension[:match]}")
                  }
                else
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_header").
                      with_content("# MANAGED BY PUPPET\nupstream #{title} {\n")
                  }
                end
                it {
                  is_expected.to contain_concat__fragment("#{title}_upstream_member_#{params[:members].keys[0]}").
                    with_content("  server #{params[:members].keys[0]}:80;\n")
                }
                if upstream_cfg_extension[:fragment] == 'footer'
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                      with_content("#{upstream_cfg_extension[:match]}}\n")
                  }
                else
                  it {
                    is_expected.to contain_concat__fragment("#{title}_upstream_footer").
                      with_content("}\n")
                  }
                end
              end
            end

            context 'when ensure => absent' do
              let(:params) { default_params[upstreamcontext.to_sym].merge(ensure: 'absent') }
              let(:conf_d_path) { conf_d_pathes[upstreamcontext.to_sym] }

              it {
                is_expected.to compile.with_all_deps
              }
              it {
                is_expected.to contain_concat("#{conf_d_path}/#{title}-upstream.conf").
                  with_ensure('absent')
              }
            end
          end
        end
      end
    end
  end
end
