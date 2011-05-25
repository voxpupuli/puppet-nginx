Resource Types
==============

Define resource types in this directory.

Filenames should match the resource type name; for example, a resource
type `mytype`, defined like this:

    Puppet::Type.newtype(:mytype) do
        @doc = "Documentation here."
        # ...
    end

Should be found in `mytype.rb`
