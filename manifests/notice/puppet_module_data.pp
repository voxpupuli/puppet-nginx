class nginx::notice::puppet_module_data {
  $message = "[nginx] *** DEPRECATION WARNING***: HI! I notice that you're declaring some attributes in Class[nginx]. We are in the process of moving all of these attributes to Hiera with puppet-module-tool. Please check out https://github.com/jfryman/puppet-nginx/blob/master/docs/hiera.md for more information."

  notify { $message: }
}