class sampleapp (
  $deployref = 'master',
  $ensure = 'latest',
) {

  include apache
  include java
  include git
  tomcat::install { '/opt/tomcat':
    source_url => 'http://apache.mirrors.tds.net/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz',
  } ->
  tomcat::instance{ 'default':
    catalina_home => '/opt/tomcat',
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
