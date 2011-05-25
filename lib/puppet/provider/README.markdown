Providers
=========

Define providers under this directory.

File paths should match the resource type name and provider name; for
example, a provider `myprovider` for a resource type `mytype`, defined like this:

    Puppet::Type.type(:mytype).provide(:myprovider) do
        desc "Documentation here"
        # ...
    end

Should be found in `mytype/myprovider.rb` under this directory.
