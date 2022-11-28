# @summary custom type for gzip_proxied
# @see http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_proxied
type Nginx::GzipProxied = Enum['off', 'expired', 'no-cache', 'no-store', 'private', 'no_last_modified', 'no_etag', 'auth', 'any']
