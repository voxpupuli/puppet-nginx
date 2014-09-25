# Usage of Hiera

This module takes advantage of the `puppet-module-data` pattern as introduced
by R.I. Pinnear to allow for a significant amount of flexibility with base
configuration of the module. This is to reduce the amount of clutter starting
to gather in `params.pp`, and provide a foundation for future enhancements.

## Installation

In order to leverage `puppet-module-data`, you must add an additional
configuration item to your `hiera.yaml` file to load the new backend. Simply
add the following code block.

```
:backends:
...
  - module_data
```

### Vagrant

In order to use this module with Vagrant, you will need to also configure
Vagrant to load up Hiera. This can be done with the following directives
in your Vagrantfile.

```
  config.vm.provision "puppet" do |puppet|
    ...
    puppet.hiera_config_path = "hiera.yaml"
    puppet.options           = "--pluginsync"
  end
```

For a full example, please take a look at https://gist.github.com/jfryman/e9f08affec54307e5198
to get additional information to bootstrap this module.

## Upgrading

If you happen to be here because of some silly deprecation notice, it is
probably because a manifest is declaring attributes for the Nginx Class.
Upgrading should be easy!

* Step 1: Make sure you have Hiera configured. https://docs.puppetlabs.com/hiera/1/puppet.html#puppet-3-and-newer
* Step 2: Move any declared parameters to hiera.
* Step 3: Profit!

For example:

```
class { 'nginx':
  logdir => '/data/nginx/logs',
}
```

should become in your hiera configs:

```
nginx::config::logdir: /data/nginx/logs
```

Please note: This module takes advantage of Puppet 3 data module bindings.
Be aware of any gotchas that accompany this. Take a look at https://docs.puppetlabs.com/hiera/1/puppet.html#limitations

## I cannot/do not use Hiera! NOW WHAT!

Do not fret! This is a big change to the core module, and it may be difficult
to make the conversion right away. First off, we intend to make it blatantly
clear when the module will tear out the parameters in Class[nginx] as
detailed in the deprecation notice. (The current target is v1.0)

In the event that you are unable to leverage Hiera for your attribute configuration, you can use the Spaceship Operator to set the parameters for the nginx::config class. For example:

```ruby
Class<| title == 'nginx::class' |> {
  proxy_cache_levels => '2',
}
```
The recommended path is to use Hiera, but this pattern should give you an intermediate step during the upgrade process.

