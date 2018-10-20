type Nginx::UpstreamMemberServer = Variant[Stdlib::Host,Pattern[/^unix:\/([^\/\0]+\/*)[^:]*$/]]
