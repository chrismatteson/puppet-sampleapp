class sampleapp (
  $deployref = 'master',
  $ensure = 'latest',
) {

  include apache
  include java
  include git
  class { 'tomcat':
    install_from_source => false,
  }->
  tomcat::instance{ 'default':
    package_name => 'tomcat',
  }->
  tomcat::service { 'default':
    use_jsvc     => false,
    use_init     => true,
    service_name => 'tomcat',
  }->
  vcsrepo { '/var/lib/tomcat/webapps/':
    ensure   => $ensure,
    provider => 'git',
    source   => 'git://github.com/chrismatteson/Sample-App.git',
    revision => $deployref,
    require  => Package['git'],
  }

  firewall { '100 allow tomcat':
    dport   => 8080,
    proto  => 'tcp',
    action => 'accept',
  }
}
