define nginx::notice::resources {
  $message = "[nginx] *** DEPRECATION WARNING***: HI! We're in the process of moving all the defined types from the `resources` namespace to the toplevel. Your defined resource, ${calling_module}[$name] should be adjusted to use the new resource location. New additions will only be added to the top-level resource, and the `resources` namespace will disappear at v1.0.0. Please check out https://github.com/jfryman/puppet-nginx/blob/master/docs/resources.md for more information."

  notify { $message: }
}
