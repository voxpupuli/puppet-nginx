# Usage of Hiera

This module takes advantage of the `puppet-module-data` pattern as introduced
by R.I. Pinnear to allow for a significant amount of flexibility with base
configuration of the module. This is to reduce the amount of clutter starting
to gather in `params.pp`, and provide a foundation for future enhancements.

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
