type Nginx::Time = Variant[
  Integer[0],
  Pattern[/^(?!$)((\d+y *)?(\d+M *)?(\d+w *)?(\d+d *)?(\d+h *)?(\d+m *)?(\d+s *)?(\d+ms)?|\d+)$/],
]
