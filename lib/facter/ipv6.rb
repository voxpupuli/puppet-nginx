#  ipv6 support
#  returns a true/false to see if the kernel has ipv6 support 
#  installed and determine addresses

require 'facter'
Facter.add("ipv6") do
    setcode do
      ipv6_exists = 'unknown'
      if Facter.value('kernel').value?('Linux')
        ipv6_exists = File.exist?('/proc/net/if_inet6') ? true : false
      end  
      ipv6_exists
    end
end