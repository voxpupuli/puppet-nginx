# A QuickStart Guide to the NGINX Module

The goal of this module is to simplify the deployment and management of 

## Why NGINX?

Before going too far, make sure that the [NGINX][] web server is appropriate for your needs. NGINX 
was designed to be a scalable web and proxy server with the abiilty to handle 
thousands of concurrent connections, but it is not designed to manage dynamic content.  For dynamic 
web applications, NGINX must be configured to _proxy_ connections to a different process.  For 
example, a PHP application in the common "LAMP Stack" configuration with Apache and PHP only requires a 
few dynamic modules and configuration changes.  Running the same application with an NGINX infrastructure
 requires the configuration of a NGINX proxy layer and a secondary runtime such as [PHP-FPM][phpfpm]. This
 can add complexity to setting up the infrastructure, but it does allow you to scale application layers
 independently.  For a good comparison of how NGINX differs from Apache, [DigitalOcean][] published 
 a [good article][nginxvsapache] detailing some of the differences between the two.
 
**NOTE**:  At this point, the module only supports Debian or RedHat based linux distributions.

## Basic NGINX Installation and Configuration

Installing NGINX and setting up your first web host is relatively straightforward.  To install
NGINX with the puppet module, simply call the class in a puppet manifest:
```
   class{'nginx': }
```
This will install the NGINX package from the software repository of your Linux distribution, which can often be quite dated.  If you would like to install NGINX from repositories maintained by the NGINX project directly, allow the `nginx` class to manage package repositories:

```
class{'nginx':
    manage_repo => true,
    package_source => 'nginx-mainline'
}
```
The choices here are `nginx-stable` (the current 'production' level release) and `nginx-mainline` (where active development is occuring) - you can read a full explanation of the differences [here][nginxpackages].  

### Creating Your First Virtual Host

Calling the `nginx` class from your manifest simply installs the NGINX software and puts some basic configuration in place.  In this state, NGINX will not serve web pages or proxy to other services - for that, we need to define a *server*.  In NGINX terminology, a *server* is how we define our services (such as websites) with a name.  (If you are used to configuring Apache, a server is identical to an Apache *virtual host*.)  A simple virtual host that serves static web pages can be defined with a server name and a *web root*, or the directory where our HTML pages are located.

```
  nginx::resource::vhost{'www.myhost.com':
    www_root => '/opt/html/',
  }
```
In this example, the DNS address `www.myhost.com` will serve pages from the `/opt/html` directory.

### Defining 


[nginx]: http://nginx.org
[phpfpm]: http://php-fpm.org
[nginxpackages]: http://nginx.org/packages/mainline
[nginxdocs]: http://nginx.org/en/docs/
[puppetlabsapache]: https://forge.puppetlabs.com/puppetlabs/apache
[digitalocean]: https://www.digitalocean.com
[nginxvsapache]: https://www.digitalocean.com/community/tutorials/apache-vs-nginx-practical-considerations