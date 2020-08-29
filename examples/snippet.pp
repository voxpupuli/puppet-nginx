class { 'nginx':
  snippets_dir        => '/etc/nginx/snippets',
}

# https://github.com/relud/puppet-lint-strict_indent-check/issues/20
# lint:ignore:strict_indent
$snippet = @("SNIPPET"/L)
location @custom_451_error {
  return 451;
}
| SNIPPET
# lint:endignore
nginx::resource::snippet { 'test_snippet':
  raw_content   => $snippet,
}

nginx::resource::server { 'test.local:8080':
  ensure        => present,
  listen_port   => 8080,
  server_name   => ['test.local test'],
  include_files => ["${nginx::snippets_dir}/test_snippet.conf"],
  try_files     => ['non-existant', '@custom_451_error'],
}

nginx::resource::server { 'test.local:8081':
  ensure        => present,
  listen_port   => 8081,
  server_name   => ['test.local test'],
  include_files => ["${nginx::snippets_dir}/test_snippet.conf"],
  try_files     => ['non-existant', '@custom_451_error'],
}
