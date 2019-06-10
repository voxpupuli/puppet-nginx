require 'spec_helper'

describe 'nginx::resource::server' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :title do
        'www.rspec.example.com'
      end

      let :default_params do
        {
          www_root: '/',
          ipv6_enable: true,
          listen_unix_socket_enable: true,
          fastcgi_index: 'index.php'
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

          it { is_expected.to contain_class('nginx') }
          it do
            is_expected.to contain_concat("/etc/nginx/sites-available/#{title}.conf").with('owner' => 'root',
                                                                                           'group' => 'root',
                                                                                           'mode' => '0644')
          end
          it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{access_log\s+/var/log/nginx/www\.rspec\.example\.com\.access\.log combined;}) }
          it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{error_log\s+/var/log/nginx/www\.rspec\.example\.com\.error\.log}) }
          it { is_expected.to contain_concat__fragment("#{title}-footer") }
          it { is_expected.to contain_nginx__resource__location("#{title}-default") }
          it { is_expected.not_to contain_file('/etc/nginx/fastcgi.conf') }
          it do
            is_expected.to contain_file("#{title}.conf symlink").with('ensure' => 'link',
                                                                      'path'   => "/etc/nginx/sites-enabled/#{title}.conf",
                                                                      'target' => "/etc/nginx/sites-available/#{title}.conf")
          end
        end

        describe 'with $confd_only enabled' do
          let(:pre_condition) { 'class { "nginx": confd_only => true }' }
          let(:params) { default_params }

          it { is_expected.to contain_class('nginx') }
          it do
            is_expected.to contain_concat("/etc/nginx/conf.d/#{title}.conf").with('owner' => 'root',
                                                                                  'group' => 'root',
                                                                                  'mode' => '0644')
            is_expected.not_to contain_file('/etc/nginx/sites-enabled')
            is_expected.not_to contain_file('/etc/nginx/sites-available')
          end
        end

        describe 'with both $rewrite_www_to_non_www and $rewrite_non_www_to_www enabled' do
          let(:params) do
            default_params.merge(rewrite_non_www_to_www: true, rewrite_www_to_non_www: true)
          end

          it do
            is_expected.to compile.and_raise_error(
              %r{You must not set both \$rewrite_www_to_non_www and \$rewrite_non_www_to_www to true}
            )
          end
        end

        describe 'server_header template content' do
          [
            {
              title: 'should not contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: false,
              notmatch: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+http://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: true,
              match: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+http://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should set the IPv4 listen IP',
              attr: 'listen_ip',
              value: '127.0.0.1',
              match: %r{\s+listen\s+127.0.0.1:80;}
            },
            {
              title: 'should set the IPv4 listen port',
              attr: 'listen_port',
              value: 45,
              match: %r{\s+listen\s+\*:45;}
            },
            {
              title: 'should set the IPv4 listen options',
              attr: 'listen_options',
              value: 'spdy default',
              match: %r{\s+listen\s+\*:80 spdy default;}
            },
            {
              title: 'should enable IPv6',
              attr: 'ipv6_enable',
              value: true,
              match: %r{\s+listen\s+\[::\]:80 default ipv6only=on;}
            },
            {
              title: 'should not enable IPv6',
              attr: 'ipv6_enable',
              value: false,
              notmatch: %r{\slisten \[::\]:80 default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen IP',
              attr: 'ipv6_listen_ip',
              value: '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
              match: %r{\s+listen\s+\[2001:0db8:85a3:0000:0000:8a2e:0370:7334\]:80 default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen port',
              attr: 'ipv6_listen_port',
              value: 45,
              match: %r{\s+listen\s+\[::\]:45 default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen options',
              attr: 'ipv6_listen_options',
              value: 'spdy',
              match: %r{\s+listen\s+\[::\]:80 spdy;}
            },
            {
              title: 'should enable listening on unix socket',
              attr: 'listen_unix_socket_enable',
              value: true,
              match: %r{\s+listen\s+unix:/var/run/nginx\.sock;}
            },
            {
              title: 'should not enable listening on unix socket',
              attr: 'listen_unix_socket_enable',
              value: false,
              notmatch: %r{\s+listen\s+unix:/var/run/nginx\.sock;}
            },
            {
              title: 'should set the listen unix socket',
              attr: 'listen_unix_socket',
              value: '/var/run/puppet_nginx.sock',
              match: %r{\s+listen\s+unix:/var/run/puppet_nginx\.sock;}
            },
            {
              title: 'should set the listen unix socket options',
              attr: 'listen_unix_socket_options',
              value: 'spdy',
              match: %r{\s+listen\s+unix:/var/run/nginx\.sock spdy;}
            },
            {
              title: 'should set servername(s)',
              attr: 'server_name',
              value: ['www.foo.com', 'foo.com'],
              match: %r{\s+server_name\s+www.foo.com foo.com;}
            },
            {
              title: 'should rewrite www servername to non-www',
              attr: 'rewrite_www_to_non_www',
              value: true,
              match: %r{\s+server_name\s+rspec.example.com;}
            },
            {
              title: 'should not rewrite www servername to non-www',
              attr: 'rewrite_www_to_non_www',
              value: false,
              match: %r{\s+server_name\s+www.rspec.example.com;}
            },
            {
              title: 'should not set absolute_redirect',
              attr: 'absolute_redirect',
              value: :undef,
              notmatch: %r{absolute_redirect}
            },
            {
              title: 'should set absolute_redirect off',
              attr: 'absolute_redirect',
              value: 'off',
              match: '  absolute_redirect off;'
            },
            {
              title: 'should set auth_basic',
              attr: 'auth_basic',
              value: 'value',
              match: %r{\s+auth_basic\s+"value";}
            },
            {
              title: 'should set auth_basic_user_file',
              attr: 'auth_basic_user_file',
              value: 'value',
              match: %r{\s+auth_basic_user_file\s+value;}
            },
            {
              title: 'should set auth_request',
              attr: 'auth_request',
              value: 'value',
              match: %r{\s+auth_request\s+value;}
            },
            {
              title: 'should set the client_body_timeout',
              attr: 'client_body_timeout',
              value: 'value',
              match: %r{^\s+client_body_timeout\s+value;}
            },
            {
              title: 'should set the client_header_timeout',
              attr: 'client_header_timeout',
              value: 'value',
              match: %r{^\s+client_header_timeout\s+value;}
            },
            {
              title: 'should set the gzip_types',
              attr: 'gzip_types',
              value: 'value',
              match: %r{^\s+gzip_types\s+value;}
            },
            {
              title: 'should contain raw_prepend directives',
              attr: 'raw_prepend',
              value: [
                'if (a) {',
                '  b;',
                '}'
              ],
              match: %r{^\s+if \(a\) \{\n\s++b;\n\s+\}}
            },
            {
              title: 'should contain ordered prepended directives',
              attr: 'server_cfg_prepend',
              value: { 'test1' => ['test value 1a', 'test value 1b'], 'test2' => 'test value 2', 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1a;',
                '  test1 test value 1b;',
                '  test2 test value 2;'
              ]
            },
            {
              title: 'should set root',
              attr: 'use_default_location',
              value: false,
              match: '  root /;'
            },
            {
              title: 'should not set root',
              attr: 'use_default_location',
              value: true,
              notmatch: %r{  root /;}
            },
            {
              title: 'should force https (SSL) redirect',
              attr: 'ssl_redirect',
              value: true,
              match: %r{  return 301 https://\$host\$request_uri;}
            },
            {
              title: 'should not force https (SSL) redirect',
              attr: 'ssl_redirect',
              value: false,
              notmatch: %r{\s*return\s+301}
            },
            {
              title: 'should set access_log',
              attr: 'access_log',
              value: '/path/to/access.log',
              match: '  access_log            /path/to/access.log combined;'
            },
            {
              title: 'should set multiple access_log directives',
              attr: 'access_log',
              value: ['/path/to/log/1', 'syslog:server=localhost'],
              match: [
                '  access_log            /path/to/log/1 combined;',
                '  access_log            syslog:server=localhost combined;'
              ]
            },
            {
              title: 'should set access_log off',
              attr: 'access_log',
              value: 'off',
              match: '  access_log            off;'
            },
            {
              title: 'should set access_log to syslog',
              attr: 'access_log',
              value: 'syslog:server=localhost',
              match: '  access_log            syslog:server=localhost combined;'
            },
            {
              title: 'should set format_log custom_format',
              attr: 'format_log',
              value: 'custom',
              match: '  access_log            /var/log/nginx/www.rspec.example.com.access.log custom;'
            },
            {
              title: 'should not include access_log in server when set to absent',
              attr: 'access_log',
              value: 'absent',
              notmatch: 'access_log'
            },
            {
              title: 'should set error_log',
              attr: 'error_log',
              value: '/path/to/error.log',
              match: '  error_log             /path/to/error.log;'
            },
            {
              title: 'should allow multiple error_log directives',
              attr: 'error_log',
              value: ['/path/to/error.log', 'syslog:server=localhost'],
              match: [
                '  error_log             /path/to/error.log;',
                '  error_log             syslog:server=localhost;'
              ]
            },
            {
              title: 'should not include error_log in server when set to absent',
              attr: 'error_log',
              value: 'absent',
              notmatch: 'error_log'
            },
            {
              title: 'should set error_pages',
              attr: 'error_pages',
              value: { '503' => '/foo.html' },
              match: '  error_page  503 /foo.html;'
            },
            {
              title: 'should set index_file(s)',
              attr: 'index_files',
              value: %w[name1 name2],
              match: %r{\s*index\s+name1\s+name2;}
            },
            {
              title: 'should not set index_file(s)',
              attr: 'index_files',
              value: [],
              notmatch: %r{\s+index\s+}
            },
            {
              title: 'should set autoindex',
              attr: 'autoindex',
              value: 'on',
              match: '  autoindex on;'
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_concat__fragment("#{title}-header") }
              it param[:title] do
                matches = Array(param[:match])

                if matches.all? { |m| m.is_a? Regexp }
                  matches.each { |item| is_expected.to contain_concat__fragment("#{title}-header").with_content(item) }
                else
                  lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
                  expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
                end
              end
            end
          end

          context 'with a naked domain title' do
            let(:title) { 'rspec.example.com' }

            [
              {
                title: 'should not contain non-www to www rewrite',
                attr: 'rewrite_non_www_to_www',
                value: false,
                notmatch: %r{
                ^
                \s+server_name\s+rspec\.example\.com;\n
                \s+return\s+301\s+http://www\.rspec\.example\.com\$request_uri;
                }x
              },
              {
                title: 'should contain non-www to www rewrite',
                attr: 'rewrite_non_www_to_www',
                value: true,
                match: %r{
                ^
                \s+server_name\s+rspec\.example\.com;\n
                \s+return\s+301\s+http://www\.rspec\.example\.com\$request_uri;
                }x
              },
              {
                title: 'should rewrite non-www servername to www',
                attr: 'rewrite_non_www_to_www',
                value: true,
                match: %r{\s+server_name\s+www.rspec.example.com;}
              },
              {
                title: 'should not rewrite non-www servername to www',
                attr: 'rewrite_non_www_to_www',
                value: false,
                notmatch: %r{\s+server_name\s+www.rspec.example.com;}
              }
            ].each do |param|
              context "when #{param[:attr]} is #{param[:value]}" do
                let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

                it { is_expected.to contain_concat__fragment("#{title}-header") }
                it param[:title] do
                  matches = Array(param[:match])

                  if matches.all? { |m| m.is_a? Regexp }
                    matches.each { |item| is_expected.to contain_concat__fragment("#{title}-header").with_content(item) }
                  else
                    lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
                    expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                  end
                  Array(param[:notmatch]).each do |item|
                    is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
                  end
                end
              end
            end
          end
        end

        describe 'server_footer template content' do
          [
            {
              title: 'should not contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: false,
              notmatch: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+https://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should contain include directives',
              attr: 'include_files',
              value: ['/file1', '/file2'],
              match: [
                %r{^\s+include\s+/file1;},
                %r{^\s+include\s+/file2;}
              ]
            },
            {
              title: 'should contain ordered appended directives',
              attr: 'server_cfg_append',
              value: { 'test1' => 'test value 1', 'test2' => ['test value 2a', 'test value 2b'], 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1;',
                '  test2 test value 2a;',
                '  test2 test value 2b;'
              ]
            },
            {
              title: 'should contain raw_append directives',
              attr: 'raw_append',
              value: [
                'if (a) {',
                '  b;',
                '}'
              ],
              match: %r{^\s+if \(a\) \{\n\s++b;\n\s+\}}
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_concat__fragment("#{title}-footer") }
              it param[:title] do
                matches = Array(param[:match])

                if matches.all? { |m| m.is_a? Regexp }
                  matches.each { |item| is_expected.to contain_concat__fragment("#{title}-footer").with_content(item) }
                else
                  lines = catalogue.resource('concat::fragment', "#{title}-footer").send(:parameters)[:content].split("\n")
                  expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}-footer").without_content(item)
                end
              end
            end
          end
        end

        context 'with a naked domain title' do
          [
            {
              title: 'should not contain non-www to www rewrite',
              attr: 'rewrite_non_www_to_www',
              value: false,
              notmatch: %r{
              ^
              \s+server_name\s+rspec\.example\.com;\n
              \s+return\s+301\s+https://www\.rspec\.example\.com\$request_uri;
              }x
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_concat__fragment("#{title}-footer") }
              it param[:title] do
                matches = Array(param[:match])

                if matches.all? { |m| m.is_a? Regexp }
                  matches.each { |item| is_expected.to contain_concat__fragment("#{title}-footer").with_content(item) }
                else
                  lines = catalogue.resource('concat::fragment', "#{title}-footer").send(:parameters)[:content].split("\n")
                  expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}-footer").without_content(item)
                end
              end
            end
          end
        end

        describe 'server_ssl_header template content' do
          context 'with ssl' do
            let :params do
              default_params.merge(
                ssl: true,
                ssl_key: '/tmp/dummy.key',
                ssl_cert: '/tmp/dummy.crt'
              )
            end

            context 'without a value for the nginx_version fact do' do
              let :facts do
                facts[:nginx_version] ? facts.delete(:nginx_version) : facts
              end

              it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{  ssl on;}) }
            end
            context 'with fact nginx_version=1.14.1' do
              let(:facts) { facts.merge(nginx_version: '1.14.1') }

              it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{  ssl on;}) }
            end

            context 'with fact nginx_version=1.15.1' do
              let(:facts) { facts.merge(nginx_version: '1.15.1') }

              it { is_expected.to contain_concat__fragment("#{title}-ssl-header").without_content(%r{  ssl on;}) }
            end

            context 'with ssl cert and key definitions' do
              let(:pre_condition) do
                <<-PUPPET
                file { ['/tmp/dummy.key', '/tmp/dummy.crt']: }
                include nginx
                PUPPET
              end

              it { is_expected.to contain_file('/tmp/dummy.key').with_path('/tmp/dummy.key') }
              it { is_expected.to contain_concat__fragment("#{title}-ssl-header").that_requires(['File[/tmp/dummy.key]', 'File[/tmp/dummy.crt]']) }
            end
          end

          [
            {
              title: 'should not contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: false,
              notmatch: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+https://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: true,
              match: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+https://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should set the IPv4 listen IP',
              attr: 'listen_ip',
              value: '127.0.0.1',
              match: %r{\s+listen\s+127.0.0.1:443 ssl;}
            },
            {
              title: 'should set the IPv4 SSL listen port',
              attr: 'ssl_port',
              value: 45,
              match: %r{\s+listen\s+\*:45 ssl;}
            },
            {
              title: 'should set SPDY',
              attr: 'spdy',
              value: 'on',
              match: %r{\s+listen\s+\*:443 ssl spdy;}
            },
            {
              title: 'should not set SPDY',
              attr: 'spdy',
              value: 'off',
              match: %r{\s+listen\s+\*:443 ssl;}
            },
            {
              title: 'should set HTTP2',
              attr: 'http2',
              value: 'on',
              match: %r{\s+listen\s+\*:443 ssl http2;}
            },
            {
              title: 'should not set HTTP2',
              attr: 'http2',
              value: 'off',
              match: %r{\s+listen\s+\*:443 ssl;}
            },
            {
              title: 'should set the IPv4 listen options',
              attr: 'listen_options',
              value: 'default',
              match: %r{\s+listen\s+\*:443 ssl default;}
            },
            {
              title: 'should enable IPv6',
              attr: 'ipv6_enable',
              value: true,
              match: %r{\s+listen\s+\[::\]:443 ssl default ipv6only=on;}
            },
            {
              title: 'should disable IPv6',
              attr: 'ipv6_enable',
              value: false,
              notmatch: %r{  listen \[::\]:443 ssl default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen IP',
              attr: 'ipv6_listen_ip',
              value: '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
              match: %r{\s+listen\s+\[2001:0db8:85a3:0000:0000:8a2e:0370:7334\]:443 ssl default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen port',
              attr: 'ssl_port',
              value: 45,
              match: %r{\s+listen\s+\[::\]:45 ssl default ipv6only=on;}
            },
            {
              title: 'should set the IPv6 listen options',
              attr: 'ipv6_listen_options',
              value: 'spdy default',
              match: %r{\s+listen\s+\[::\]:443 ssl spdy default;}
            },
            {
              title: 'should set servername(s)',
              attr: 'server_name',
              value: ['www.foo.com', 'foo.com'],
              match: %r{\s+server_name\s+www.foo.com foo.com;}
            },
            {
              title: 'should rewrite www servername to non-www',
              attr: 'rewrite_www_to_non_www',
              value: true,
              match: %r{\s+server_name\s+rspec.example.com;}
            },
            {
              title: 'should not rewrite www servername to non-www',
              attr: 'rewrite_www_to_non_www',
              value: false,
              match: %r{\s+server_name\s+www.rspec.example.com;}
            },
            {
              title: 'should set the SSL buffer size',
              attr: 'ssl_buffer_size',
              value: '4k',
              match: '  ssl_buffer_size           4k;'
            },
            {
              title: 'should set the SSL client certificate file',
              attr: 'ssl_client_cert',
              value: '/tmp/client_certificate',
              match: %r{\s+ssl_client_certificate\s+/tmp/client_certificate;}
            },
            {
              title: 'should set the SSL CRL file',
              attr: 'ssl_crl',
              value: '/tmp/crl',
              match: %r{\s+ssl_crl\s+/tmp/crl;}
            },
            {
              title: 'should set the SSL DH parameters file',
              attr: 'ssl_dhparam',
              value: '/tmp/dhparam',
              match: %r{\s+ssl_dhparam\s+/tmp/dhparam;}
            },
            {
              title: 'should set ssl_ecdh_curve',
              attr: 'ssl_ecdh_curve',
              value: 'secp521r1',
              match: %r{\s+ssl_ecdh_curve\s+secp521r1;}
            },
            {
              title: 'should set the SSL stapling file',
              attr: 'ssl_stapling_file',
              value: '/tmp/stapling_file',
              match: %r{\s+ssl_stapling_file\s+/tmp/stapling_file;}
            },
            {
              title: 'should set the SSL trusted certificate file',
              attr: 'ssl_trusted_cert',
              value: '/tmp/trusted_certificate',
              match: %r{\s+ssl_trusted_certificate\s+/tmp/trusted_certificate;}
            },
            {
              title: 'should set ssl_verify_depth',
              attr: 'ssl_verify_depth',
              value: 2,
              match: %r{^\s+ssl_verify_depth\s+2;}
            },
            {
              title: 'should set the SSL cache',
              attr: 'ssl_cache',
              value: 'shared:SSL:1m',
              match: %r{\s+ssl_session_cache\s+shared:SSL:1m;}
            },
            {
              title: 'should set the SSL timeout',
              attr: 'ssl_session_timeout',
              value: '30m',
              match: '  ssl_session_timeout       30m;'
            },
            {
              title: 'should set the SSL protocols',
              attr: 'ssl_protocols',
              value: 'TLSv1',
              match: %r{\s+ssl_protocols\s+TLSv1;}
            },
            {
              title: 'should set the SSL ciphers',
              attr: 'ssl_ciphers',
              value: 'HIGH',
              match: %r{\s+ssl_ciphers\s+HIGH;}
            },
            {
              title: 'should set ssl_prefer_server_ciphers on',
              attr: 'ssl_prefer_server_ciphers',
              value: 'on',
              match: %r{\s+ssl_prefer_server_ciphers\s+on;}
            },
            {
              title: 'should set ssl_prefer_server_ciphers off',
              attr: 'ssl_prefer_server_ciphers',
              value: 'off',
              match: %r{\s+ssl_prefer_server_ciphers\s+off;}
            },
            {
              title: 'should not set absolute_redirect',
              attr: 'absolute_redirect',
              value: :undef,
              notmatch: %r{absolute_redirect}
            },
            {
              title: 'should set absolute_redirect off',
              attr: 'absolute_redirect',
              value: 'off',
              match: '  absolute_redirect off;'
            },
            {
              title: 'should set auth_basic',
              attr: 'auth_basic',
              value: 'value',
              match: %r{\s+auth_basic\s+"value";}
            },
            {
              title: 'should set auth_basic_user_file',
              attr: 'auth_basic_user_file',
              value: 'value',
              match: %r{\s+auth_basic_user_file\s+"value";}
            },
            {
              title: 'should set auth_request',
              attr: 'auth_request',
              value: 'value',
              match: %r{\s+auth_request\s+value;}
            },
            {
              title: 'should set the client_body_timeout',
              attr: 'client_body_timeout',
              value: 'value',
              match: %r{^\s+client_body_timeout\s+value;}
            },
            {
              title: 'should set the client_header_timeout',
              attr: 'client_header_timeout',
              value: 'value',
              match: %r{^\s+client_header_timeout\s+value;}
            },
            {
              title: 'should set the gzip_types',
              attr: 'gzip_types',
              value: 'value',
              match: %r{^\s+gzip_types\s+value;}
            },
            {
              title: 'should set access_log',
              attr: 'access_log',
              value: '/path/to/access.log',
              match: '  access_log            /path/to/access.log combined;'
            },
            {
              title: 'should set multiple access_log directives',
              attr: 'access_log',
              value: ['/path/to/log/1', 'syslog:server=localhost'],
              match: [
                '  access_log            /path/to/log/1 combined;',
                '  access_log            syslog:server=localhost combined;'
              ]
            },
            {
              title: 'should set access_log off',
              attr: 'access_log',
              value: 'off',
              match: '  access_log            off;'
            },
            {
              title: 'should not include access_log in server when set to absent',
              attr: 'access_log',
              value: 'absent',
              notmatch: 'access_log'
            },
            {
              title: 'should set access_log to syslog',
              attr: 'access_log',
              value: 'syslog:server=localhost',
              match: '  access_log            syslog:server=localhost combined;'
            },
            {
              title: 'should set format_log custom_format',
              attr: 'format_log',
              value: 'custom',
              match: '  access_log            /var/log/nginx/ssl-www.rspec.example.com.access.log custom;'
            },
            {
              title: 'should set error_log',
              attr: 'error_log',
              value: '/path/to/error.log',
              match: '  error_log             /path/to/error.log;'
            },
            {
              title: 'should allow multiple error_log directives',
              attr: 'error_log',
              value: ['/path/to/error.log', 'syslog:server=localhost'],
              match: [
                '  error_log             /path/to/error.log;',
                '  error_log             syslog:server=localhost;'
              ]
            },
            {
              title: 'should not include error_log in server when set to absent',
              attr: 'error_log',
              value: 'absent',
              notmatch: 'error_log'
            },
            {
              title: 'should set error_pages',
              attr: 'error_pages',
              value: { '503' => '/foo.html' },
              match: '  error_page  503 /foo.html;'
            },
            {
              title: 'should contain raw_prepend directives',
              attr: 'raw_prepend',
              value: [
                'if (a) {',
                '  b;',
                '}'
              ],
              match: %r{^\s+if \(a\) \{\n\s++b;\n\s+\}}
            },
            {
              title: 'should contain ordered prepend directives',
              attr: 'server_cfg_prepend',
              value: { 'test1' => 'test value 1', 'test2' => ['test value 2a', 'test value 2b'], 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1;',
                '  test2 test value 2a;',
                '  test2 test value 2b;'
              ]
            },
            {
              title: 'should contain ordered ssl prepend directives',
              attr: 'server_cfg_ssl_prepend',
              value: { 'test1' => 'test value 1', 'test2' => ['test value 2a', 'test value 2b'], 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1;',
                '  test2 test value 2a;',
                '  test2 test value 2b;'
              ]
            },
            {
              title: 'should set root',
              attr: 'use_default_location',
              value: false,
              match: '  root /;'
            },
            {
              title: 'should not set root',
              attr: 'use_default_location',
              value: true,
              notmatch: %r{  root /;}
            },
            {
              title: 'should set index_file(s)',
              attr: 'index_files',
              value: %w[name1 name2],
              match: %r{\s*index\s+name1\s+name2;}
            },
            {
              title: 'should not set index_file(s)',
              attr: 'index_files',
              value: [],
              notmatch: %r{\s+index\s+}
            },
            {
              title: 'should set autoindex',
              attr: 'autoindex',
              value: 'on',
              match: '  autoindex on;'
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let :params do
                default_params.merge(param[:attr].to_sym => param[:value],
                                     :ssl                => true,
                                     :ssl_key            => 'dummy.key',
                                     :ssl_cert           => 'dummy.crt')
              end

              it { is_expected.to contain_concat__fragment("#{title}-ssl-header") }
              it param[:title] do
                matches = Array(param[:match])

                if matches.all? { |m| m.is_a? Regexp }
                  matches.each { |item| is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(item) }
                else
                  lines = catalogue.resource('concat::fragment', "#{title}-ssl-header").send(:parameters)[:content].split("\n")
                  expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}-ssl-header").without_content(item)
                end
              end
            end
          end
        end

        describe 'server_ssl_footer template content' do
          [
            {
              title: 'should not contain www to non-www rewrite',
              attr: 'rewrite_www_to_non_www',
              value: false,
              notmatch: %r{
              ^
              \s+server_name\s+www\.rspec\.example\.com;\n
              \s+return\s+301\s+https://rspec\.example\.com\$request_uri;
              }x
            },
            {
              title: 'should contain include directives',
              attr: 'include_files',
              value: ['/file1', '/file2'],
              match: [
                %r{^\s+include\s+/file1;},
                %r{^\s+include\s+/file2;}
              ]
            },
            {
              title: 'should contain ordered appended directives',
              attr: 'server_cfg_append',
              value: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1;',
                '  test2 test value 2;'
              ]
            },
            {
              title: 'should contain raw_append directives',
              attr: 'raw_append',
              value: [
                'if (a) {',
                '  b;',
                '}'
              ],
              match: %r{^\s+if \(a\) \{\n\s++b;\n\s+\}}
            },
            {
              title: 'should contain ordered ssl appended directives',
              attr: 'server_cfg_ssl_append',
              value: { 'test1' => 'test value 1', 'test2' => ['test value 2a', 'test value 2b'], 'allow' => 'test value 3' },
              match: [
                '  allow test value 3;',
                '  test1 test value 1;',
                '  test2 test value 2a;',
                '  test2 test value 2b;'
              ]
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let :params do
                default_params.merge(param[:attr].to_sym => param[:value],
                                     :ssl                => true,
                                     :ssl_key            => 'dummy.key',
                                     :ssl_cert           => 'dummy.crt')
              end

              it { is_expected.to contain_concat__fragment("#{title}-ssl-footer") }
              it param[:title] do
                matches = Array(param[:match])

                if matches.all? { |m| m.is_a? Regexp }
                  matches.each { |item| is_expected.to contain_concat__fragment("#{title}-ssl-footer").with_content(item) }
                else
                  lines = catalogue.resource('concat::fragment', "#{title}-ssl-footer").send(:parameters)[:content].split("\n")
                  expect(lines & Array(param[:match])).to eq(Array(param[:match]))
                end
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_concat__fragment("#{title}-ssl-footer").without_content(item)
                end
              end
            end
          end
        end

        context 'attribute resources' do
          context 'with SSL enabled, www rewrite to naked domain with multiple server_names' do
            let(:title) { 'foo.com' }
            let(:params) do
              {
                ssl: true,
                ssl_cert: 'cert',
                ssl_key: 'key',
                server_name: %w[www.foo.com bar.foo.com foo.com],
                use_default_location: false,
                rewrite_www_to_non_www: true
              }
            end

            it "sets the server_name of the rewrite server stanza to every server_name with 'www.' stripped" do
              is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{^\s+server_name\s+foo.com\s+bar.foo.com\s+foo.com;})
            end
          end

          context 'with SSL disabled, www rewrite to naked domain with multiple server_names' do
            let(:title) { 'foo.com' }
            let(:params) do
              {
                server_name: %w[www.foo.com bar.foo.com foo.com],
                use_default_location: false,
                rewrite_www_to_non_www: true
              }
            end

            it "sets the server_name of the rewrite server stanza to every server_name with 'www.' stripped" do
              is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{^\s+server_name\s+foo.com\s+bar.foo.com\s+foo.com;})
            end
          end

          context 'ssl_redirect' do
            let(:params) { { ssl_redirect: true } }

            it { is_expected.to contain_concat__fragment("#{title}-header").without_content(%r{^\s*index\s+}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").without_content(%r{^\s*location\s+}) }
          end

          context 'ssl_redirect with alternate port' do
            let(:params) { { ssl_redirect: true, ssl_port: 8888 } }

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{  return 301 https://\$host:8888\$request_uri;}) }
          end

          context 'ssl_redirect with standard port set explicitly' do
            let(:params) { { ssl_redirect: true, ssl_port: 443 } }

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{  return 301 https://\$host\$request_uri;}) }
          end

          context 'ssl_redirect with overridden port' do
            let(:params) { { ssl_redirect: true, ssl_redirect_port: 8878 } }

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{  return 301 https://\$host:8878\$request_uri;}) }
          end

          context 'ssl_redirect with ssl_port set and overridden redirect port' do
            let(:params) do
              {
                ssl_redirect: true,
                ssl_redirect_port: 9787,
                ssl_port: 9783
              }
            end

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{  return 301 https://\$host:9787\$request_uri;}) }
          end

          context 'ssl_redirect should set ssl_only when ssl => true' do
            let(:params) do
              {
                ssl_redirect: true,
                ssl: true,
                ssl_key: 'dummy.key',
                ssl_cert: 'dummy.crt'
              }
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_ssl_only(true) }
          end

          context 'ssl_redirect should not include default location when ssl => false' do
            let(:params) do
              {
                ssl_redirect: true,
                ssl: false
              }
            end

            it { is_expected.not_to contain_nginx__resource__location("#{title}-default") }
          end

          context 'SSL cert and key are both set to fully qualified paths' do
            let(:params) { { ssl: true, ssl_cert: '/tmp/foo.crt', ssl_key: '/tmp/foo.key:' } }

            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{ssl_certificate\s+/tmp/foo.crt}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{ssl_certificate_key\s+/tmp/foo.key}) }
          end

          context 'SSL cert and key are both set to false' do
            let(:params) { { ssl: true, ssl_cert: false, ssl_key: false } }

            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").without_content(%r{ssl_certificate}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").without_content(%r{ssl_certificate_key}) }
          end

          context 'when use_default_location => true' do
            let :params do
              default_params.merge(use_default_location: true)
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default") }
          end

          context 'when use_default_location => false' do
            let :params do
              default_params.merge(use_default_location: false)
            end

            it { is_expected.not_to contain_nginx__resource__location("#{title}-default") }
          end

          context 'when location_cfg_prepend => { key => value }' do
            let :params do
              default_params.merge(location_cfg_prepend: { 'key' => 'value' })
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_location_cfg_prepend('key' => 'value') }
          end

          context "when location_raw_prepend => [ 'foo;' ]" do
            let :params do
              default_params.merge(location_raw_prepend: ['foo;'])
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_raw_prepend(['foo;']) }
          end

          context "when location_raw_append => [ 'foo;' ]" do
            let :params do
              default_params.merge(location_raw_append: ['foo;'])
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_raw_append(['foo;']) }
          end

          context 'when location_cfg_append => { key => value }' do
            let :params do
              default_params.merge(location_cfg_append: { 'key' => 'value' })
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_location_cfg_append('key' => 'value') }
          end

          context 'when fastcgi => "localhost:9000"' do
            let :params do
              default_params.merge(fastcgi: 'localhost:9000')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_fastcgi_params('/etc/nginx/fastcgi.conf') }
            it { is_expected.to contain_file('/etc/nginx/fastcgi.conf').with_mode('0644') }
          end

          context 'when fastcgi_params is non-default' do
            let :params do
              default_params.merge(fastcgi: 'localhost:9000',
                                   fastcgi_params: '/etc/nginx/mycustomparams')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_fastcgi_params('/etc/nginx/mycustomparams') }
            it { is_expected.not_to contain_file('/etc/nginx/mycustomparams') }
          end

          context 'when fastcgi_params is not defined' do
            let :params do
              default_params.merge(fastcgi: 'localhost:9000',
                                   fastcgi_params: nil)
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_fastcgi_params('nil') }
            it { is_expected.not_to contain_file('/etc/nginx/fastcgi.conf') }
          end

          context 'when fastcgi_index => "index.php"' do
            let :params do
              default_params.merge(fastcgi_index: 'index.php')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_fastcgi_index('index.php') }
          end

          context 'when fastcgi_param => {key => value}' do
            let :params do
              default_params.merge(fastcgi_param: { 'key' => 'value' })
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_fastcgi_param('key' => 'value') }
          end

          context 'when uwsgi => "uwsgi_upstream"' do
            let :params do
              default_params.merge(uwsgi: 'uwsgi_upstream')
            end

            it { is_expected.to contain_file('/etc/nginx/uwsgi_params').with_mode('0644') }
          end

          context 'when uwsgi_params is non-default' do
            let :params do
              default_params.merge(uwsgi: 'uwsgi_upstream',
                                   uwsgi_params: '/etc/nginx/bogusparams')
            end

            it { is_expected.not_to contain_file('/etc/nginx/bogusparams') }
          end

          context 'when listen_port == ssl_port but ssl = false' do
            let :params do
              default_params.merge(listen_port: 80,
                                   ssl_port: 80,
                                   ssl: false)
            end

            # TODO: implement test after this can be tested
            # msg = %r{nginx: ssl must be true if listen_port is the same as ssl_port}
            it 'Testing for warnings not yet implemented in classes'
          end

          context 'when listen_port != ssl_port' do
            let :params do
              default_params.merge(listen_port: 80,
                                   ssl_port: 443)
            end

            it { is_expected.to contain_concat__fragment("#{title}-header") }
            it { is_expected.to contain_concat__fragment("#{title}-footer") }
          end

          context 'when ensure => absent' do
            let :params do
              default_params.merge(ensure: 'absent',
                                   ssl: true,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_ensure('absent') }
            it { is_expected.to contain_file("#{title}.conf symlink").with_ensure('absent') }
            it { is_expected.to contain_concat("/etc/nginx/sites-available/#{title}.conf").with_ensure('absent') }
          end

          context 'when ssl => true and ssl_port == listen_port' do
            let :params do
              default_params.merge(ssl: true,
                                   listen_port: 80,
                                   ssl_port: 80,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_ssl_only(true) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{access_log\s+/var/log/nginx/ssl-www\.rspec\.example\.com\.access\.log combined;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{error_log\s+/var/log/nginx/ssl-www\.rspec\.example\.com\.error\.log}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{ssl_certificate\s+dummy.cert;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{ssl_certificate_key\s+dummy.key;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-footer") }
          end

          context 'when ssl_client_cert is set' do
            let :params do
              default_params.merge(ssl: true,
                                   listen_port: 80,
                                   ssl_port: 80,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert',
                                   ssl_client_cert: 'client.cert',
                                   ssl_verify_client: 'optional')
            end

            it { is_expected.to contain_nginx__resource__location("#{title}-default").with_ssl_only(true) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{access_log\s+/var/log/nginx/ssl-www\.rspec\.example\.com\.access\.log combined;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{error_log\s+/var/log/nginx/ssl-www\.rspec\.example\.com\.error\.log}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{ssl_verify_client\s+optional;}) }
          end
          context 'when passenger_cgi_param is set' do
            let :params do
              default_params.merge(passenger_cgi_param: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' })
            end

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_cgi_param  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_cgi_param  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_cgi_param  test3 test value 3;}) }
          end

          context 'when passenger_cgi_param is set and ssl => true' do
            let :params do
              default_params.merge(passenger_cgi_param: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' },
                                   ssl: true,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_cgi_param  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_cgi_param  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_cgi_param  test3 test value 3;}) }
          end

          context 'when passenger_set_header is set' do
            let :params do
              default_params.merge(passenger_set_header: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' })
            end

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_header  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_header  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_set_header  test3 test value 3;}) }
          end

          context 'when passenger_set_header is set and ssl => true' do
            let :params do
              default_params.merge(passenger_set_header: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' },
                                   ssl: true,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_header  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_header  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_set_header  test3 test value 3;}) }
          end

          context 'when passenger_env_var is set' do
            let :params do
              default_params.merge(passenger_env_var: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' })
            end

            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_env_var  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_env_var  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{passenger_env_var  test3 test value 3;}) }
          end

          context 'when passenger_env_var is set and ssl => true' do
            let :params do
              default_params.merge(passenger_env_var: { 'test1' => 'test value 1', 'test2' => 'test value 2', 'test3' => 'test value 3' },
                                   ssl: true,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_env_var  test1 test value 1;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_env_var  test2 test value 2;}) }
            it { is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{passenger_env_var  test3 test value 3;}) }
          end

          context 'when passenger_pre_start is a string' do
            let :params do
              default_params.merge(passenger_pre_start: 'http://example.com:80/test/me')
            end

            it { is_expected.to contain_concat__fragment("#{title}-footer").with_content(%r{passenger_pre_start http://example.com:80/test/me;}) }
          end

          context 'when passenger_pre_start is an array' do
            let :params do
              default_params.merge(passenger_pre_start: ['http://example.com:80/test/me', 'http://example.com:3009/foo/bar'])
            end

            it { is_expected.to contain_concat__fragment("#{title}-footer").with_content(%r{passenger_pre_start http://example.com:80/test/me;}) }
            it { is_expected.to contain_concat__fragment("#{title}-footer").with_content(%r{passenger_pre_start http://example.com:3009/foo/bar;}) }
          end

          context 'when server name is sanitized' do
            let(:title) { 'www rspec-server com' }
            let(:params) { default_params }

            it { is_expected.to contain_concat('/etc/nginx/sites-available/www_rspec-server_com.conf') }
          end

          context 'when add_header is set' do
            let :params do
              default_params.merge(add_header: { 'header3' => { '' => '\'test value 3\' tv3' }, 'header2' => { 'test value 2' => 'tv2' }, 'header1' => 'test value 1' })
            end

            it 'has correctly ordered entries in the config' do
              is_expected.to contain_concat__fragment("#{title}-header").with_content(%r{\s+add_header\s+"header1" "test value 1";\n\s+add_header\s+"header2" "test value 2" tv2;\n\s+add_header\s+"header3"  'test value 3' tv3;\n})
            end
          end

          context 'when add_header is set and ssl => true' do
            let :params do
              default_params.merge(add_header: { 'header3' => { '' => '\'test value 3\' tv3' }, 'header2' => { 'test value 2' => 'tv2' }, 'header1' => 'test value 1' },
                                   ssl: true,
                                   ssl_key: 'dummy.key',
                                   ssl_cert: 'dummy.cert')
            end

            it 'has correctly ordered entries in the config' do
              is_expected.to contain_concat__fragment("#{title}-ssl-header").with_content(%r{\s+add_header\s+"header1" "test value 1";\n\s+add_header\s+"header2" "test value 2" tv2;\n\s+add_header\s+"header3"  'test value 3' tv3;\n})
            end
          end
        end

        describe 'with locations' do
          context 'simple location' do
            let(:params) do
              {
                use_default_location: false,
                locations: {
                  'one' => {
                    'location_custom_cfg' => {},
                    'location' => '/one',
                    'expires' => '@12h34m'
                  }
                }
              }
            end

            it { is_expected.to contain_nginx__resource__location('one') }
            it { is_expected.to contain_nginx__resource__location('one').with_location('/one') }
            it { is_expected.to contain_nginx__resource__location('one').with_expires('@12h34m') }
          end

          context 'multiple locations' do
            let(:params) do
              {
                use_default_location: false,
                locations: {
                  'one' => {
                    'location_custom_cfg' => {},
                    'location' => '/one',
                    'expires' => '@12h34m'
                  },
                  'two' => {
                    'location_custom_cfg' => {},
                    'location' => '= /two',
                    'expires' => '@23h45m'
                  }
                }
              }
            end

            it { is_expected.to contain_nginx__resource__location('one') }
            it { is_expected.to contain_nginx__resource__location('one').with_location('/one') }
            it { is_expected.to contain_nginx__resource__location('one').with_expires('@12h34m') }
            it { is_expected.to contain_nginx__resource__location('two') }
            it { is_expected.to contain_nginx__resource__location('two').with_location('= /two') }
            it { is_expected.to contain_nginx__resource__location('two').with_expires('@23h45m') }
          end

          context 'with locations default' do
            let(:params) do
              {
                www_root: '/toplevel',
                locations_defaults: {
                  'www_root' => '/overwrite',
                  'expires' => '@12h34m'
                },
                locations: {
                  'one' => {
                    'location_custom_cfg' => {},
                    'location' => '/one'
                  },
                  'two' => {
                    'location_custom_cfg' => {},
                    'location' => '= /two'
                  }
                }
              }
            end

            it { is_expected.to contain_nginx__resource__location('one') }
            it { is_expected.to contain_nginx__resource__location('one').with_location('/one') }
            it { is_expected.to contain_nginx__resource__location('one').with_www_root('/overwrite') }
            it { is_expected.to contain_nginx__resource__location('one').with_expires('@12h34m') }
            it { is_expected.to contain_nginx__resource__location('two') }
            it { is_expected.to contain_nginx__resource__location('two').with_location('= /two') }
            it { is_expected.to contain_nginx__resource__location('two').with_www_root('/overwrite') }
            it { is_expected.to contain_nginx__resource__location('two').with_expires('@12h34m') }
          end
        end
      end
    end
  end
end
