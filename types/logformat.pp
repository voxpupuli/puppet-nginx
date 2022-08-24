type Nginx::LogFormat = Variant[
  String[1],
  Struct[{
    Optional[escape] => Enum['default', 'json', 'none'],
    format           => String[1],
  }],
]
