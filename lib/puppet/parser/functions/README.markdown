Functions
=========

Define functions in this directory.

File paths should match the function name; for example, a function
`myfunction`, defined like this:

    Puppet::Parser::Functions::newfunction(
        :myfunction,
        :type => :statement,
        :doc => "Documentation here."
    ) do |vals|
        # ...
    end

Should be found in `myfunction.rb` in this directory.
