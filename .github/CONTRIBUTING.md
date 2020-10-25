# Contribution guidelines

## Table of contents

* [Contributing](#contributing)
* [Writing proper commits - short version](#writing-proper-commits-short-version)
* [Writing proper commits - long version](#writing-proper-commits-long-version)
* [Dependencies](#dependencies)
  * [Note for OS X users](#note-for-os-x-users)
* [The test matrix](#the-test-matrix)
* [Syntax and style](#syntax-and-style)
* [Running the unit tests](#running-the-unit-tests)
* [Unit tests in docker](#unit-tests-in-docker)
* [Integration tests](#integration-tests)

This module has grown over time based on a range of contributions from
people using it. If you follow these contributing guidelines your patch
will likely make it into a release a little more quickly.

## Contributing

Please note that this project is released with a Contributor Code of Conduct.
By participating in this project you agree to abide by its terms.
[Contributor Code of Conduct](https://voxpupuli.org/coc/).

* Fork the repo.
* Create a separate branch for your change.
* We only take pull requests with passing tests, and documentation. [travis-ci](http://travis-ci.org) runs the tests for us. You can also execute them locally. This is explained [in a later section](#the-test-matrix).
* Checkout [our docs](https://voxpupuli.org/docs/reviewing_pr/) we use to review a module and the [official styleguide](https://puppet.com/docs/puppet/6.0/style_guide.html). They provide some guidance for new code that might help you before you submit a pull request.
* Add a test for your change. Only refactoring and documentation changes require no new tests. If you are adding functionality or fixing a bug, please add a test.
* Squash your commits down into logical components. Make sure to rebase against our current master.
* Push the branch to your fork and submit a pull request.

Please be prepared to repeat some of these steps as our contributors review your code.

Also consider sending in your profile code that calls this component module as an acceptance test or provide it via an issue. This helps reviewers a lot to test your use case and prevents future regressions!

## Writing proper commits - short version

* Make commits of logical units.
* Check for unnecessary whitespace with "git diff --check" before committing.
* Commit using Unix line endings (check the settings around "crlf" in git-config(1)).
* Do not check in commented out code or unneeded files.
* The first line of the commit message should be a short description (50 characters is the soft limit, excluding ticket number(s)), and should skip the full stop.
* Associate the issue in the message. The first line should include the issue number in the form "(#XXXX) Rest of message".
* The body should provide a meaningful commit message, which:
  *uses the imperative, present tense: `change`, not `changed` or `changes`.
  * includes motivation for the change, and contrasts its implementation with the previous behavior.
  * Make sure that you have tests for the bug you are fixing, or feature you are adding.
  * Make sure the test suites passes after your commit:
  * When introducing a new feature, make sure it is properly documented in the README.md

## Writing proper commits - long version

  1.  Make separate commits for logically separate changes.

      Please break your commits down into logically consistent units
      which include new or changed tests relevant to the rest of the
      change.  The goal of doing this is to make the diff easier to
      read for whoever is reviewing your code.  In general, the easier
      your diff is to read, the more likely someone will be happy to
      review it and get it into the code base.

      If you are going to refactor a piece of code, please do so as a
      separate commit from your feature or bug fix changes.

      We also really appreciate changes that include tests to make
      sure the bug is not re-introduced, and that the feature is not
      accidentally broken.

      Describe the technical detail of the change(s).  If your
      description starts to get too long, that is a good sign that you
      probably need to split up your commit into more finely grained
      pieces.

      Commits which plainly describe the things which help
      reviewers check the patch and future developers understand the
      code are much more likely to be merged in with a minimum of
      bike-shedding or requested changes.  Ideally, the commit message
      would include information, and be in a form suitable for
      inclusion in the release notes for the version of Puppet that
      includes them.

      Please also check that you are not introducing any trailing
      whitespace or other "whitespace errors".  You can do this by
      running "git diff --check" on your changes before you commit.

  2.  Sending your patches

      To submit your changes via a GitHub pull request, we _highly_
      recommend that you have them on a topic branch, instead of
      directly on `master`.
      It makes things much easier to keep track of, especially if
      you decide to work on another thing before your first change
      is merged in.

      GitHub has some pretty good
      [general documentation](http://help.github.com/) on using
      their site.  They also have documentation on
      [creating pull requests](http://help.github.com/send-pull-requests/).

      In general, after pushing your topic branch up to your
      repository on GitHub, you can switch to the branch in the
      GitHub UI and click "Pull Request" towards the top of the page
      in order to open a pull request.


  3.  Update the related GitHub issue.

      If there is a GitHub issue associated with the change you
      submitted, then you should update the ticket to include the
      location of your branch, along with any other commentary you
      may wish to make.

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
bundle install --path .vendor/ --without development system_tests release --jobs "$(nproc)"
```

If you also want to run acceptance tests:

```sh
bundle install --path .vendor/ --with system_tests --without development release --jobs "$(nproc)"
```

Our all in one solution if you don't know if you need to install or update gems:

```sh
bundle install --path .vendor/ --with system_tests --without development release --jobs "$(nproc)"; bundle update; bundle clean
```

As an alternative to the `--jobs "$(nproc)` parameter, you can set an
environment variable:

```sh
BUNDLE_JOBS="$(nproc)"
```

### Note for OS X users

`nproc` isn't a valid command under OS x. As an alternative, you can do:

```sh
--jobs "$(sysctl -n hw.ncpu)"
```

## The test matrix

### Syntax and style

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

### Running the unit tests

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

#### Unit tests in docker

Some people don't want to run the dependencies locally or don't want to install
ruby. We ship a Dockerfile that enables you to run all unit tests and linting.
You only need to run:

```sh
docker build .
```

Please ensure that a docker daemon is running and that your user has the
permission to talk to it. You can specify a remote docker host by setting the
`DOCKER_HOST` environment variable. it will copy the content of the module into
the docker image. So it will not work if a Gemfile.lock exists.

### Integration tests

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

```sh
PUPPET_INSTALL_TYPE=agent BEAKER_IS_PE=no BEAKER_PUPPET_COLLECTION=puppet6 BEAKER_debug=true BEAKER_setfile=debian10-64{hypervisor=docker} BEAKER_destroy=yes bundle exec rake beaker
```

You can replace the string `debian10` with any common operating system.
The following strings are known to work:

* ubuntu1604
* ubuntu1804
* ubuntu2004
* debian9
* debian10
* centos6
* centos7
* centos8

The easiest way to debug in a docker container is to open a shell:

```sh
docker exec -it -u root ${container_id_or_name} bash
```

The source of this file is in our [modulesync_config](https://github.com/voxpupuli/modulesync_config/blob/master/moduleroot/.github/CONTRIBUTING.md.erb)
repository.
