include ::nginx

::nginx::resource::location { 'www.test.com-alias':
    ensure         => present,
    location       => '/some/url',
    location_alias => '/new/url/',
    server         => 'www.test.com',
}
