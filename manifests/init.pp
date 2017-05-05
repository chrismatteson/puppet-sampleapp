class sampleapp (
  $artifactserver,
  $version,
) {

  include apache
  include java
  tomcat::install { '/opt/tomcat':
    source_url => 'http://apache.mirrors.tds.net/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz',
  } ->
  tomcat::instance{ 'default':
    catalina_home => '/opt/tomcat',
  } ->
  file { '/opt/tomcat/webapps/sample.war':
    ensure => file,
    mode   => '0644',
    source => "http://${artifactserver}/sample-${version}.war",
  }
  firewall { '100 allow tomcat':
    dport   => 8080,
    proto  => 'tcp',
    action => 'accept',
  }
}
