require 'puppet'
pkg = Puppet::Type.type(:package).new(:name => "nginx")
Facter.add("nginx_version") do
  setcode do
    /^(\d+\.\d+\.\d+).*$/.match(pkg.retrieve[pkg.property(:ensure)])[1]
  end
end
