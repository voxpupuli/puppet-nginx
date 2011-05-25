Facter
======

Define facts in this directory.

Sometimes you need to be able to write conditional expressions based
on site-specific data that just isn’t available via Facter. The
solution may be to add a fact to Facter. These additional facts can
then be distributed to Puppet clients and are available for use in
manifests. Learn more at
http://projects.puppetlabs.com/projects/puppet/wiki/Adding_Facts

File paths should match the fact name; for example, a fact
`hardware_platform`, defined like this:

    Facter.add("hardware_platform") do
        setcode do
            %x{/bin/uname -i}.chomp
        end
    end

Should be found in `hardware_platform.rb` in this directory.
