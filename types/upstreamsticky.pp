type Nginx::UpstreamSticky = Variant[
  Hash[
    Enum['cookie'],
    Struct[{
      name     => String,
      expires  => Optional[Variant[Nginx::Time,Enum['max']]],
      domain   => Optional[String],
      httponly => Optional[Boolean],
      secure   => Optional[Boolean],
      path     => Optional[String],
    }]
  ],
  Hash[
    Enum['route'],
    String
  ],
  Hash[
    Enum['learn'],
    Struct[{
      create  => String,
      lookup  => String,
      zone    => Nginx::UpstreamStickyZone,
      timeout => Optional[Nginx::Time],
      header  => Optional[Boolean],
      sync    => Optional[Boolean],
    }]
  ]
]
