# Make nginx version available as a fact
require 'puppet'
pkg = Puppet::Type.type(:package).new(:name => "nginx")
Facter.add("nginx_version") do
  has_weight 100
  setcode do
    Facter::Util::Resolution.exec('nginx -v 2>&1')
  end
end

Facter.add("nginx_version") do
  has_weight 50
  setcode do
    if pkg.retrieve[pkg.property(:ensure)] != 'purged'
        /^(\d+\.\d+\.\d+).*$/.match(pkg.retrieve[pkg.property(:ensure)])[1]
    end
  end
end
