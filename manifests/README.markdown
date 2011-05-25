Manifests
=========

Module manifest files belong in this directory.

`init.pp` defines how the module will carry out its tasks in this file.

Add additional definitions in this directory. Their file paths should match the
definition name; for example, a definition `mydefinition`, defined like this:

    # Definition: mydefinition
    #
    # This is the mydefinition in the mymodule module.
    #
    # Parameters:
    #
    # Actions:
    #
    # Requires:
    #
    # Sample Usage:
    #
    # [Remember: No empty lines between comments and class definition]
    define mydefinition {
        # ...
    }

Should be found in `mydefinition.pp` in this directory.
