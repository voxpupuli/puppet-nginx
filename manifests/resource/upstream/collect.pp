# Class to collect exported upstream members, if needed.
#
# This is separated into a separate class in order to remove errors if
# storeconfigs are unavailable.

class nginx::resource::upstream::collect (
  $upstream_name,
)
{
  # Collect exported members:
  ::Nginx::Resource::Upstream::Member <<| upstream == $upstream_name |>>
}
