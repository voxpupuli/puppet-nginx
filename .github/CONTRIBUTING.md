This module has grown over time based on a range of contributions from
people using it. If you follow these contributing guidelines your patch
will likely make it into a release a little more quickly.

## Contributing

Please note that this project is released with a Contributor Code of Conduct.
By participating in this project you agree to abide by its terms.
[Contributor Code of Conduct](https://voxpupuli.org/coc/).

1. Fork the repo.

1. Create a separate branch for your change.

1. We only take pull requests with passing tests, and documentation. [travis-ci](http://travis-ci.org)
   runs the tests for us. You can also execute them locally. This is explained
   in a later section.

1. Checkout [our docs](https://voxpupuli.org/docs/#reviewing-a-module-pr) we
   use to review a module and the [official styleguide](https://puppet.com/docs/puppet/6.0/style_guide.html).
   They provide some guidance for new code that might help you before you submit a pull request.

1. Add a test for your change. Only refactoring and documentation
   changes require no new tests. If you are adding functionality
   or fixing a bug, please add a test.

1. Squash your commits down into logical components. Make sure to rebase
   against our current master.

1. Push the branch to your fork and submit a pull request.

Please be prepared to repeat some of these steps as our contributors review
your code.

## Dependencies

The testing and development tools have a bunch of dependencies,
all managed by [bundler](http://bundler.io/) according to the
[Puppet support matrix](http://docs.puppetlabs.com/guides/platforms.html#ruby-versions).

By default the tests use a baseline version of Puppet.

If you have Ruby 2.x or want a specific version of Puppet,
you must set an environment variable such as:

```sh
export PUPPET_VERSION="~> 5.5.6"
```

You can install all needed gems for spec tests into the modules directory by
running:

```sh
bundle install --path .vendor/ --without development --without system_tests --without release
```

If you also want to run acceptance tests:

```sh
bundle install --path .vendor/ --without development --with system_tests --without release
```

Our all in one solution if you don't know if you need to install or update gems:

```sh
bundle install --path .vendor/ --without development --with system_tests --without release; bundle update; bundle clean
```

## Syntax and style

The test suite will run [Puppet Lint](http://puppet-lint.com/) and
[Puppet Syntax](https://github.com/gds-operations/puppet-syntax) to
check various syntax and style things. You can run these locally with:

```sh
bundle exec rake lint
bundle exec rake validate
```

It will also run some [Rubocop](http://batsov.com/rubocop/) tests
against it. You can run those locally ahead of time with:

```sh
bundle exec rake rubocop
```

## Running the unit tests

The unit test suite covers most of the code, as mentioned above please
add tests if you're adding new functionality. If you've not used
[rspec-puppet](http://rspec-puppet.com/) before then feel free to ask
about how best to test your new feature.

To run the linter, the syntax checker and the unit tests:

```sh
bundle exec rake test
```

To run your all the unit tests

```sh
bundle exec rake spec
```

To run a specific spec test set the `SPEC` variable:

```sh
bundle exec rake spec SPEC=spec/foo_spec.rb
```

## Integration tests

The unit tests just check the code runs, not that it does exactly what
we want on a real machine. For that we're using
[beaker](https://github.com/puppetlabs/beaker).

This fires up a new virtual machine (using vagrant) and runs a series of
simple tests against it after applying the module. You can run this
with:

```sh
bundle exec rake acceptance
```

This will run the tests on the module's default nodeset. You can override the
nodeset used, e.g.,

```sh
BEAKER_set=centos-7-x64 bundle exec rake acceptance
```

There are default rake tasks for the various acceptance test modules, e.g.,

```sh
bundle exec rake beaker:centos-7-x64
bundle exec rake beaker:ssh:centos-7-x64
```

If you don't want to have to recreate the virtual machine every time you can
use `BEAKER_destroy=no` and `BEAKER_provision=no`. On the first run you will at
least need `BEAKER_provision` set to yes (the default). The Vagrantfile for the
created virtual machines will be in `.vagrant/beaker_vagrant_files`.

Beaker also supports docker containers. We also use that in our automated CI
pipeline at [travis-ci](http://travis-ci.org). To use that instead of Vagrant:

```
PUPPET_INSTALL_TYPE=agent BEAKER_IS_PE=no BEAKER_PUPPET_COLLECTION=puppet5 BEAKER_debug=true BEAKER_setfile=debian9-64{hypervisor=docker} BEAKER_destroy=yes bundle exec rake beaker
```

You can replace the string `debian9` with any common operating system.
The following strings are known to work:

* ubuntu1604
* ubuntu1804
* debian8
* debian9
* centos6
* centos7

The easiest way to debug in a docker container is to open a shell:

```sh
docker exec -it -u root ${container_id_or_name} bash
```

The source of this file is in our [modulesync_config](https://github.com/voxpupuli/modulesync_config/blob/master/moduleroot/.github/CONTRIBUTING.md.erb)
repository.
