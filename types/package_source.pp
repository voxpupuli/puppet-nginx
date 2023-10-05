# Where to download NGINX from
#
# There are three versions of NGINX available:
# * stable (`nginx` or `nginx-stable`);
# * mainline (`nginx-mainline`);
# * passenger (`passenger`).
#
# The mainline branch gets new features and bugfixes sooner but might introduce new bugs as well. Critical bugfixes are backported to the stable branch.
#
# In general, the stable release is recommended, but the mainline release is typically quite stable as well.
#
# In addition, Phusion provide packages for NGINX + Passenger (`passenger`).
type Nginx::Package_source = Enum[
  'nginx',
  'nginx-stable',
  'nginx-mainline',
  'passenger',
]
