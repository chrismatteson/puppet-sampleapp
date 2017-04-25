class sampleapp (
  $deployref = 'master',
  $ensure = 'latest',
) {

  include apache
  include java
  tomcat::install { '/opt/tomcat':
    source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.x/bin/apache-tomcat-7.0.x.tar.gz',
  } ->
  tomcat::instance{ 'default':
    catalina_home => '/opt/tomcat',
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
