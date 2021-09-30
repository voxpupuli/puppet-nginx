type Nginx::Log_format = Variant[
  String[1],
  Tuple[
    Enum[
      'escape=default',
      'escape=json',
      'escape=none',
    ],
    String[1],
  ],
]
