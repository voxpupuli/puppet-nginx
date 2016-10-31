# Usage of Hiera

Going forward, it is recommended to declare your changes in Hiera based on the system(s) role and location in your environment. In Puppet < 3.x, this is accomplished with Hiera bindings.

## Example Conversion

Say for a moment that you have this code block:

```ruby
class { 'nginx':
  gzip => false,
}
```

Moving this to hiera is simple. First, identify the appropriate hiera level to apply this attribute. (A node or role level is recommended). Then, add the following codeblock...

```yaml
---
  nginx::config::gzip: false
```

## I (cannot/do not want to) use Hiera

Maybe for some reason, Hiera isn't being used in your organization. Or, you like to keep a certain amount of composibilty in you modules. Or, hidden option #3! Regardless, the recommended path is to instantiate your own copy of Class[nginx::config] and move on with life. Let's do another example.

Assume you have the following code block:

```ruby
class { 'nginx' :
  manage_repo   => false,
  confd_purge   => true,
  vhost_purge   => true,
}
```

This should become...

```ruby
Anchor['nginx::begin']
->
class { 'nginx::config' :
  confd_purge   => true,
  vhost_purge   => true,
}

class { 'nginx' :
  manage_repo   => false,
}
```

The order in which this commands are parsed is important, since nginx looks for nginx::config via a defined(nginx::config) statement, which as of puppet 3.x is still parse-order dependent.

