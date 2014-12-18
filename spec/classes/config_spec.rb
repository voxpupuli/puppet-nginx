require 'spec_helper'
describe 'nginx::config' do

  context 'with defaults' do
        it { is_expected.to contain_file("/etc/nginx").only_with(
          :path   => "/etc/nginx",
          :ensure => 'directory',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/etc/nginx/conf.d").only_with(
          :path   => '/etc/nginx/conf.d',
          :ensure => 'directory',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/etc/nginx/conf.mail.d").only_with(
          :path   => '/etc/nginx/conf.mail.d',
          :ensure => 'directory',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/etc/nginx/conf.d/vhost_autogen.conf").with_ensure('absent') }
        it { is_expected.to contain_file("/etc/nginx/conf.mail.d/vhost_autogen.conf").with_ensure('absent') }
        it { is_expected.to contain_file("/var/nginx").with(
          :ensure => 'directory',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/var/nginx/client_body_temp").with(
          :ensure => 'directory',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/var/nginx/proxy_temp").with(
          :ensure => 'directory',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file('/etc/nginx/sites-enabled/default').with_ensure('absent') }
        it { is_expected.to contain_file("/etc/nginx/nginx.conf").with(
          :ensure => 'file',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/etc/nginx/conf.d/proxy.conf").with(
          :ensure => 'file',
          :owner => 'root',
          :group => 'root',
          :mode => '0644'
        )}
        it { is_expected.to contain_file("/tmp/nginx.d").with(
          :ensure => 'absent',
          :purge => true,
          :recurse => true
        )}
        it { is_expected.to contain_file("/tmp/nginx.mail.d").with(
          :ensure => 'absent',
          :purge => true,
          :recurse => true
        )}
        it { is_expected.to contain_file("/var/nginx/client_body_temp").with(:owner => 'nginx')}
        it { is_expected.to contain_file("/var/nginx/proxy_temp").with(:owner => 'nginx')}
        it { is_expected.to contain_file("/etc/nginx/nginx.conf").with_content %r{^user nginx;}}

    describe "nginx.conf template content" do
      [
        {
          :title => 'should set worker_processes',
          :attr  => 'worker_processes',
          :value => '4',
          :match => 'worker_processes 4;',
        },
        {
          :title => 'should set worker_rlimit_nofile',
          :attr  => 'worker_rlimit_nofile',
          :value => '10000',
          :match => 'worker_rlimit_nofile 10000;',
        },
        {
          :title => 'should set error_log',
          :attr  => 'nginx_error_log',
          :value => '/path/to/error.log',
          :match => 'error_log  /path/to/error.log;',
        },
        {
          :title => 'should set worker_connections',
          :attr  => 'worker_connections',
          :value => '100',
          :match => '  worker_connections 100;',
        },
        {
          :title => 'should set log formats',
          :attr  => 'log_format',
          :value => {
            'format1' => 'FORMAT1',
            'format2' => 'FORMAT2',
          },
          :match => [
            '  log_format format1 \'FORMAT1\';',
            '  log_format format2 \'FORMAT2\';',
          ],
        },
        {
          :title    => 'should not set log formats',
          :attr     => 'log_format',
          :value    => {},
          :notmatch => /log_format/,
        },
        {
          :title => 'should set access_log',
          :attr  => 'http_access_log',
          :value => '/path/to/access.log',
          :match => '  access_log  /path/to/access.log;',
        },
        {
          :title => 'should set server_tokens',
          :attr  => 'server_tokens',
          :value => 'on',
          :match => '  server_tokens on;',
        },
        {
          :title => 'should set proxy_cache_path',
          :attr  => 'proxy_cache_path',
          :value => '/path/to/proxy.cache',
          :match => %r'\s+proxy_cache_path\s+/path/to/proxy.cache levels=1 keys_zone=d2:100m max_size=500m inactive=20m;',
        },
        {
          :title    => 'should not set proxy_cache_path',
          :attr     => 'proxy_cache_path',
          :value    => false,
          :notmatch => %r'\s+proxy_cache_path\s+/path/to/proxy\.cache levels=1 keys_zone=d2:100m max_size=500m inactive=20m;',
        },
        {
          :title => 'should contain ordered appended directives from hash',
          :attr  => 'http_cfg_append',
          :value => { 'test1' => 'test value 1', 'test2' => 'test value 2', 'allow' => 'test value 3' },
          :match => [
            '  allow test value 3;',
            '  test1 test value 1;',
            '  test2 test value 2;',
          ],
        },
        {
          :title => 'should contain duplicate appended directives from list of hashes',
          :attr  => 'http_cfg_append',
          :value => [[ 'allow', 'test value 1'], ['allow', 'test value 2' ]],
          :match => [
            '  allow test value 1;',
            '  allow test value 2;',
          ],
        },
        {
          :title => 'should contain duplicate appended directives from array values',
          :attr  => 'http_cfg_append',
          :value => { 'test1' => ['test value 1', 'test value 2', 'test value 3'] },
          :match => [
            '  test1 test value 1;',
            '  test1 test value 2;',
          ],
        },
        {
            :title => 'should set pid',
            :attr  => 'pid',
            :value => '/path/to/pid',
            :match => 'pid        /path/to/pid;',
        },
        {
            :title => 'should set tcp_nodelay',
            :attr  => 'http_tcp_nodelay',
            :value => 'on',
            :match => '  tcp_nodelay        on;',
        },
        {
            :title => 'should set tcp_nopush',
            :attr  => 'http_tcp_nopush',
            :value => 'on',
            :match => '  tcp_nopush on;',
        },
        {
            :title => 'should set keepalive_timeout',
            :attr  => 'keepalive_timeout',
            :value => '123',
            :match => '  keepalive_timeout  123;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :params do { param[:attr].to_sym => param[:value] } end

          it { is_expected.to contain_file("/etc/nginx/nginx.conf").with_mode('0644') }
          it param[:title] do
            matches  = Array(param[:match])

            if matches.all? { |m| m.is_a? Regexp }
              matches.each { |item| is_expected.to contain_file('/etc/nginx/nginx.conf').with_content(item) }
            else
              lines = subject.resource('file', '/etc/nginx/nginx.conf').send(:parameters)[:content].split("\n")
              expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            end

            Array(param[:notmatch]).each do |item|
              is_expected.to contain_file("/etc/nginx/nginx.conf").without_content(item)
            end
          end
        end
      end
    end

    describe "proxy.conf template content" do
      [
        {
          :title => 'should set proxy_buffers',
          :attr  => 'proxy_buffers',
          :value => '50 5k',
          :match => 'proxy_buffers           50 5k;',
        },
        {
          :title => 'should set proxy_buffer_size',
          :attr  => 'proxy_buffer_size',
          :value => '2k',
          :match => 'proxy_buffer_size       2k;',
        },
        {
          :title => 'should set proxy_http_version',
          :attr  => 'proxy_http_version',
          :value => '1.1',
          :match => 'proxy_http_version      1.1;',
        },
        {
          :title    => 'should not set proxy_http_version',
          :attr     => 'proxy_http_version',
          :value    => nil,
          :notmatch => 'proxy_http_version',
        },
        {
          :title => 'should contain ordered appended directives',
          :attr  => 'proxy_set_header',
          :value => ['header1','header2'],
          :match => [
            'proxy_set_header        header1;',
            'proxy_set_header        header2;',
          ],
        },
        {
            :title    => 'should set client_body_temp_path',
            :attr     => 'client_body_temp_path',
            :value    => '/path/to/body_temp',
            :match => 'client_body_temp_path   /path/to/body_temp;',
        },
        {
            :title    => 'should set proxy_temp_path',
            :attr     => 'proxy_temp_path',
            :value    => '/path/to/proxy_temp',
            :match => 'proxy_temp_path         /path/to/proxy_temp;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :params do { param[:attr].to_sym => param[:value] } end

          it { is_expected.to contain_file("/etc/nginx/conf.d/proxy.conf").with_mode('0644') }
          it param[:title] do
            matches  = Array(param[:match])

            if matches.all? { |m| m.is_a? Regexp }
              matches.each { |item| is_expected.to contain_file('/etc/nginx/conf.d/proxy.conf').with_content(item) }
            else
              lines = subject.resource('file', '/etc/nginx/conf.d/proxy.conf').send(:parameters)[:content].split("\n")
              expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            end

            Array(param[:notmatch]).each do |item|
              is_expected.to contain_file("/etc/nginx/conf.d/proxy.conf").without_content(item)
            end
          end
        end
      end
    end

    context "when confd_purge true" do
      let(:params) {{:confd_purge => true}}
      it { is_expected.to contain_file('/etc/nginx/conf.d').with(
        :purge => true,
        :recurse => true
      )}
    end

    context "when confd_purge false" do
      let(:params) {{:confd_purge => false}}
      it { is_expected.to contain_file('/etc/nginx/conf.d').without([
        'ignore',
        'purge',
        'recurse'
      ])}
    end

    context "when vhost_purge true" do
      let(:params) {{:vhost_purge => true}}
      it { is_expected.to contain_file('/etc/nginx/sites-available').with(
        :purge => true,
        :recurse => true
      )}
      it { is_expected.to contain_file('/etc/nginx/sites-enabled').with(
        :purge => true,
        :recurse => true
      )}
    end

    context "when vhost_purge false" do
      let(:params) {{:vhost_purge => false}}
      it { is_expected.to contain_file('/etc/nginx/sites-available').without([
        'ignore',
        'purge',
        'recurse'
      ])}
      it { is_expected.to contain_file('/etc/nginx/sites-enabled').without([
        'ignore',
        'purge',
        'recurse'
      ])}
    end

    context "when daemon_user = www-data" do
      let :params do
        {
          :daemon_user => 'www-data',
        }
      end
      it { is_expected.to contain_file("/var/nginx/client_body_temp").with(:owner => 'www-data')}
      it { is_expected.to contain_file("/var/nginx/proxy_temp").with(:owner => 'www-data')}
      it { is_expected.to contain_file("/etc/nginx/nginx.conf").with_content %r{^user www-data;}}
    end
  end
end
