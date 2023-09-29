# @summary custom type for the `map` variable mapping
# @see http://nginx.org/en/docs/http/ngx_http_map_module.html
type Nginx::StringMappings = Variant[
  Array[Struct[{ 'key' => String[1], 'value' => String }]],
  Hash[String[1], String]
]
