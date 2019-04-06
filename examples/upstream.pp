include nginx

nginx::resource::upstream { 'proxypass':
  ensure  => present,
  members => {
    'localhost:3001' => {
      server => 'localhost',
      port   => 3000,
    },
    'localhost:3002' => {
      server => 'localhost',
      port   => 3002,
    },
    'localhost:3003' => {
      server => 'localhost',
      port   => 3003,
    },
  },
}
