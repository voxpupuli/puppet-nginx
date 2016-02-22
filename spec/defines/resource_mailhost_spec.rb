require 'spec_helper'

describe 'nginx::resource::mailhost' do
  let :title do
    'www.rspec.example.com'
  end
  let :facts do
    {
      :ipaddress6      => '::',
    }
  end
  let :default_params do
    {
      :listen_port => 25,
      :ipv6_enable => true,
    }
  end
  let :pre_condition do
    [
      'include ::nginx::config',
    ]
  end

  describe 'os-independent items' do

    describe 'basic assumptions' do
      let :params do default_params end
      it { is_expected.to contain_class("nginx::config") }
      it { is_expected.to contain_concat("/etc/nginx/conf.mail.d/#{title}.conf").with({
        'owner' => 'root',
        'group' => 'root',
        'mode'  => '0644',
      })}
      it { is_expected.to contain_concat__fragment("#{title}-header") }
      it { is_expected.not_to contain_concat__fragment("#{title}-ssl") }
    end

    describe "mailhost template content" do
      [
        {
          :title => 'should set the IPv4 listen IP',
          :attr  => 'listen_ip',
          :value => '127.0.0.1',
          :match => '  listen                127.0.0.1:25;',
        },
        {
          :title => 'should set the IPv4 listen port',
          :attr  => 'listen_port',
          :value => 45,
          :match => '  listen                *:45;',
        },
        {
          :title => 'should set the IPv4 listen options',
          :attr  => 'listen_options',
          :value => 'spdy default',
          :match => '  listen                *:25 spdy default;',
        },
        {
          :title => 'should enable IPv6',
          :attr  => 'ipv6_enable',
          :value => true,
          :match => '  listen [::]:80 default ipv6only=on;',
        },
        {
          :title    => 'should not enable IPv6',
          :attr     => 'ipv6_enable',
          :value    => false,
          :notmatch => /  listen \[::\]:80 default ipv6only=on;/,
        },
        {
          :title => 'should set the IPv6 listen IP',
          :attr  => 'ipv6_listen_ip',
          :value => '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          :match => '  listen [2001:0db8:85a3:0000:0000:8a2e:0370:7334]:80 default ipv6only=on;',
        },
        {
          :title => 'should set the IPv6 listen port',
          :attr  => 'ipv6_listen_port',
          :value => 45,
          :match => '  listen [::]:45 default ipv6only=on;',
        },
        {
          :title => 'should set the IPv6 listen options',
          :attr  => 'ipv6_listen_options',
          :value => 'spdy',
          :match => '  listen [::]:80 spdy;',
        },
        {
          :title => 'should set servername(s)',
          :attr  => 'server_name',
          :value => ['name1','name2'],
          :match => '  server_name           name1 name2;',
        },
        {
          :title => 'should set protocol',
          :attr  => 'protocol',
          :value => 'test-protocol',
          :match => '  protocol              test-protocol;',
        },
        {
          :title => 'should set xclient',
          :attr  => 'xclient',
          :value => 'test-xclient',
          :match => '  xclient               test-xclient;',
        },
        {
          :title => 'should set auth_http',
          :attr  => 'auth_http',
          :value => 'test-auth_http',
          :match => '  auth_http             test-auth_http;',
        },
        {
          :title => 'should set starttls to on',
          :attr  => 'starttls',
          :value => 'on',
          :match => '  starttls  on;',
        },
        {
          :title => 'should set starttls to only',
          :attr  => 'starttls',
          :value => 'only',
          :match => '  starttls  only;',
        },
        {
          :title => 'should set starttls to only and ssl_protocols to defaul',
          :attr  => 'starttls',
          :value => 'only',
          :match => '  ssl_protocols              TLSv1 TLSv1.1 TLSv1.2;',
        },
        {
          :title    => 'should not enable SSL',
          :attr     => 'starttls',
          :value    => 'off',
          :notmatch => '  ssl_session_timeout   5m;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :ipv6_enable => true,
            :ssl_cert    => 'dummy.crt',
            :ssl_key     => 'dummy.key',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-header") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
            end
          end
        end
      end
    end

    describe "mailhost template content for imap" do
      [
        {
          :title => 'should set imap_auth',
          :attr  => 'imap_auth',
          :value => 'login',
          :match => '  imap_auth           login;',
        },
        {
          :title => 'should set imap_capabilities',
          :attr  => 'imap_capabilities',
          :value => ['"SIZE 52428800"', 'IMAP4rev1', 'UIDPLUS'],
          :match => '  imap_capabilities   "SIZE 52428800" IMAP4rev1 UIDPLUS;',
        },
        {
          :title => 'should set imap_client_buffer',
          :attr  => 'imap_client_buffer',
          :value => '8k',
          :match => '  imap_client_buffer  8k;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :ipv6_enable => true,
            :protocol    => 'imap',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-header") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
            end
          end
        end
      end
    end

    describe "mailhost template content for pop3" do
      [
        {
          :title => 'should set pop3_auth',
          :attr  => 'pop3_auth',
          :value => 'login',
          :match => '  pop3_auth          login;',
        },
        {
          :title => 'should set pop3_capabilities',
          :attr  => 'pop3_capabilities',
          :value => ['TOP', 'USER', 'UIDL'],
          :match => '  pop3_capabilities  TOP USER UIDL;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :ipv6_enable => true,
            :protocol    => 'pop3',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-header") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
            end
          end
        end
      end
    end

    describe "mailhost template content for smtp" do
      [
        {
          :title => 'should set smtp_auth',
          :attr  => 'smtp_auth',
          :value => 'login',
          :match => '  smtp_auth          login;',
        },
        {
          :title => 'should set smtp_capabilities',
          :attr  => 'smtp_capabilities',
          :value => ['8BITMIME', 'PIPELINING', 'HELP'],
          :match => '  smtp_capabilities  8BITMIME PIPELINING HELP;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :ipv6_enable => true,
            :protocol    => 'smtp',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-header") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
            end
          end
        end
      end
    end

    describe "mailhost template content (SSL enabled)" do
      [
        {
          :title => 'should enable SSL',
          :attr  => 'starttls',
          :value => 'on',
          :match => '  ssl_session_timeout        5m;',
        },
        {
          :title => 'should enable SSL',
          :attr  => 'starttls',
          :value => 'only',
          :match => '  ssl_session_timeout        5m;',
        },
        {
          :title    => 'should not enable SSL',
          :attr     => 'starttls',
          :value    => 'off',
          :notmatch => '  ssl_session_timeout       5m;',
        },
        {
          :title => 'should set ssl_certificate',
          :attr  => 'ssl_cert',
          :value => 'test-ssl-cert',
          :match => '  ssl_certificate            test-ssl-cert;',
        },
        {
          :title => 'should set ssl_certificate_key',
          :attr  => 'ssl_key',
          :value => 'test-ssl-cert-key',
          :match => '  ssl_certificate_key        test-ssl-cert-key;',
        },
        {
          :title => 'should set ssl_ciphers',
          :attr  => 'ssl_ciphers',
          :value => 'ECDHE-ECDSA-CHACHA20-POLY1305',
          :match => '  ssl_ciphers                ECDHE-ECDSA-CHACHA20-POLY1305;',
        },
        {
          :title => 'should set ssl_client_certificate',
          :attr  => 'ssl_client_cert',
          :value => 'client-cert',
          :match => '  ssl_client_certificate     client-cert;',
        },
        {
          :title => 'should set ssl_crl',
          :attr  => 'ssl_crl',
          :value => 'crl-file',
          :match => '  ssl_crl                    crl-file;',
        },
        {
          :title => 'should set ssl_dhparam',
          :attr  => 'ssl_dhparam',
          :value => 'dhparam-file',
          :match => '  ssl_dhparam                dhparam-file;',
        },
        {
          :title => 'should set ssl_ecdh_curve',
          :attr  => 'ssl_ecdh_curve',
          :value => 'secp521r1',
          :match => '  ssl_ecdh_curve             secp521r1;',
        },
        {
          :title => 'should set ssl_client_certificate',
          :attr  => 'ssl_client_cert',
          :value => 'client-cert',
          :match => '  ssl_client_certificate     client-cert;',
        },
        {
          :title => 'should set ssl_password_file',
          :attr  => 'ssl_password_file',
          :value => 'password-file',
          :match => '  ssl_password_file          password-file;',
        },
        {
          :title => 'should set ssl_protocols',
          :attr  => 'ssl_protocols',
          :value => 'TLSv1.2',
          :match => '  ssl_protocols              TLSv1.2;',
        },
        {
          :title => 'should set ssl_session_cache',
          :attr  => 'ssl_session_cache',
          :value => 'none',
          :match => '  ssl_session_cache          none;',
        },
        {
          :title => 'should set ssl_session_ticket_key',
          :attr  => 'ssl_session_ticket_key',
          :value => 'key-file',
          :match => '  ssl_session_ticket_key     key-file;',
        },
        {
          :title => 'should set ssl_session_tickets',
          :attr  => 'ssl_session_tickets',
          :value => 'on',
          :match => '  ssl_session_tickets        on;',
        },
        {
          :title => 'should set ssl_session_timeout',
          :attr  => 'ssl_session_timeout',
          :value => '20m',
          :match => '  ssl_session_timeout        20m;',
        },
        {
          :title => 'should set ssl_trusted_certificate',
          :attr  => 'ssl_trusted_cert',
          :value => 'trust-cert',
          :match => '  ssl_trusted_certificate    trust-cert;',
        },
        {
          :title => 'should set ssl_verify_depth',
          :attr  => 'ssl_verify_depth',
          :value => 2,
          :match => '  ssl_verify_depth           2;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :starttls    => 'on',
            :ssl_cert    => 'dummy.crt',
            :ssl_key     => 'dummy.key',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-header") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-header").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-header").without_content(item)
            end
          end
        end
      end
    end

    describe "mailhost_ssl template content" do
      [
        {
          :title => 'should set the IPv4 SSL listen port',
          :attr  => 'ssl_port',
          :value => '45',
          :match => '  listen       *:45;',
        },
        {
          :title => 'should enable IPv6',
          :attr  => 'ipv6_enable',
          :value => true,
          :match => '  listen [::]:587 default ipv6only=on;',
        },
        {
          :title    => 'should not enable IPv6',
          :attr     => 'ipv6_enable',
          :value    => false,
          :notmatch => /  listen \[::\]:587 default ipv6only=on;/,
        },
        {
          :title => 'should set the IPv6 listen IP',
          :attr  => 'ipv6_listen_ip',
          :value => '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
          :match => '  listen [2001:0db8:85a3:0000:0000:8a2e:0370:7334]:587 default ipv6only=on;',
        },
        {
          :title => 'should set the IPv6 ssl port',
          :attr  => 'ssl_port',
          :value => 45,
          :match => '  listen [::]:45 default ipv6only=on;',
        },
        {
          :title => 'should set the IPv6 listen options',
          :attr  => 'ipv6_listen_options',
          :value => 'spdy',
          :match => '  listen [::]:587 spdy;',
        },
        {
          :title => 'should set servername(s)',
          :attr  => 'server_name',
          :value => ['name1','name2'],
          :match => '  server_name           name1 name2;',
        },
        {
          :title => 'should set protocol',
          :attr  => 'protocol',
          :value => 'test-protocol',
          :match => '  protocol              test-protocol;',
        },
        {
          :title => 'should set xclient',
          :attr  => 'xclient',
          :value => 'test-xclient',
          :match => '  xclient               test-xclient;',
        },
        {
          :title => 'should set auth_http',
          :attr  => 'auth_http',
          :value => 'test-auth_http',
          :match => '  auth_http             test-auth_http;',
        },
        {
          :title => 'should set ssl_certificate',
          :attr  => 'ssl_cert',
          :value => 'test-ssl-cert',
          :match => '  ssl_certificate            test-ssl-cert;',
        },
        {
          :title => 'should set ssl_certificate_key',
          :attr  => 'ssl_key',
          :value => 'test-ssl-cert-key',
          :match => '  ssl_certificate_key        test-ssl-cert-key;',
        },
      ].each do |param|
        context "when #{param[:attr]} is #{param[:value]}" do
          let :default_params do {
            :listen_port => 25,
            :ssl_port    => 587,
            :ipv6_enable => true,
            :ssl         => true,
            :ssl_cert    => 'dummy.crt',
            :ssl_key     => 'dummy.key',
          } end
          let :params do default_params.merge({ param[:attr].to_sym => param[:value] }) end

          it { is_expected.to contain_concat__fragment("#{title}-ssl") }
          it param[:title] do
            lines = catalogue.resource('concat::fragment', "#{title}-ssl").send(:parameters)[:content].split("\n")
            expect(lines & Array(param[:match])).to eq(Array(param[:match]))
            Array(param[:notmatch]).each do |item|
              is_expected.to contain_concat__fragment("#{title}-ssl").without_content(item)
            end
          end
        end
      end
    end

    context 'attribute resources' do
      context "SSL cert missing and ssl => true" do
        let :params do default_params.merge({
          :ssl     => true,
          :ssl_key => 'key',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context "SSL key missing and ssl => true" do
        let :params do default_params.merge({
          :ssl      => true,
          :ssl_cert => 'cert',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context "SSL cert missing and starttls => 'on'" do
        let :params do default_params.merge({
          :starttls => 'on',
          :ssl_key  => 'key',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context "SSL key missing and starttls => 'on'" do
        let :params do default_params.merge({
          :starttls => 'on',
          :ssl_cert => 'cert',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context "SSL cert missing and starttls => 'only'" do
        let :params do default_params.merge({
          :starttls => 'only',
          :ssl_key  => 'key',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context "SSL key missing and starttls => 'only'" do
        let :params do default_params.merge({
          :starttls => 'only',
          :ssl_cert => 'cert',
        }) end

        it { expect { is_expected.to contain_class('nginx::resource::vhost') }.to raise_error(Puppet::Error, %r{nginx: SSL certificate/key \(ssl_cert/ssl_cert\) and/or SSL Private must be defined and exist on the target system\(s\)}) }
      end

      context 'when listen_port != ssl_port' do
        let :params do default_params.merge({
          :listen_port => 80,
          :ssl_port    => 443,
        }) end

        it { is_expected.to contain_concat__fragment("#{title}-header") }
      end

      context 'when listen_port == ssl_port' do
        let :params do default_params.merge({
          :listen_port => 80,
          :ssl_port    => 80,
        }) end

        it { is_expected.not_to contain_concat__fragment("#{title}-header") }
      end

      context 'when ssl => true' do
        let :params do default_params.merge({
          :ensure   => 'absent',
          :ssl      => true,
          :ssl_key  => 'dummy.key',
          :ssl_cert => 'dummy.cert',
        }) end

        it { is_expected.to contain_concat__fragment("#{title}-header") }
        it { is_expected.to contain_concat__fragment("#{title}-ssl") }
      end

      context 'when ssl => false' do
        let :params do default_params.merge({
          :ensure => 'absent',
          :ssl    => false,
        }) end

        it { is_expected.to contain_concat__fragment("#{title}-header") }
        it { is_expected.not_to contain_concat__fragment("#{title}-ssl") }
      end
    end
  end
end
