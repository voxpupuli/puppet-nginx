type Nginx::Size = Variant[
  Integer[0],
  Pattern[/\A\d+[k|K|m|M]?\z/],
]
