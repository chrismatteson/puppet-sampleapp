class sampleapp (
  $deployref = 'master',
  $ensure = 'latest',
) {

  include apache
  include java
  class { 'tomcat':
    install_from_source => false,
  }
  class { 'epel': }->
  tomcat::instance{ 'default':
    package_name => 'tomcat',
  }->
  tomcat::service { 'default':
    use_jsvc     => false,
    use_init     => true,
    service_name => 'tomcat',
  }->
  package { 'git':
    ensure => 'present',
  }->
  vcsrepo { '/var/lib/tomcat/webapps/':
    ensure   => $ensure,
    provider => 'git',
    source   => 'git://github.com/chrismatteson/Sample-App.git',
    revision => $deployref,
  }

  firewall { '100 allow tomcat':
    port   => 8080,
    proto  => 'tcp',
    action => 'accept',
  }
}
