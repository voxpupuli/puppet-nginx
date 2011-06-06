class nginx::package {
  case $operatingsystem {
    centos,fedora,rhel: {
	  include nginx::package::redhat
    }
    debian,ubuntu: {
	  include nginx::package::debian
    }
    opensuse,suse: {
	  include nginx::package::suse
    }
  }
}