server {

	listen   <%= listen %>; ## listen for ipv4
	listen   [::]:80 default ipv6only=on; ## listen for ipv6

	server_name  <%= name %>;

	access_log  <%= scope.lookupvar('nginx::params::log_dir')%>/<%= name %>.access.log;

	location / {
		root   <%= www_root %>;
		index  index.html index.htm;
	}
}

<% if ssl == 'on' %>
server {
	listen   	 443;
	server_name  <%= name %>;

	ssl  on;
	ssl_certificate  	 <%= ssl_cert %>;
	ssl_certificate_key  <%= ssl_key %>;

	ssl_session_timeout  5m;

	ssl_protocols  SSLv3 TLSv1;
	ssl_ciphers  ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
	ssl_prefer_server_ciphers   on;

	location / {
		root   <%= www_root %>;
		index  index.html index.htm;
	}
}
<% end %>