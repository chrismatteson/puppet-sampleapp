class sampleapp (
  $deployref 
) {

  include apache
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
  vcsrepo { '/tmp/Sample-App':
    ensure   => 'present',
    provider => 'git',
    source   => 'git://github.com/chrismatteson/Sample-App.git',
    revision => $deployref,
  }->
  tomcat::war { 'sample.war':
    catalina_base => '/opt/apache-tomcat/tomcat',
    war_source => '/tmp/Sample-App/sample.war',
  }

  firewall { '100 allow HTTP':
    port   => 80,
    porto  => 'tcp',
    action => 'accept',
  }
}
