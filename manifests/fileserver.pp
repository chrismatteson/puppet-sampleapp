class sampleapp::tests {
#  include 'apache'
#  include 'profile::firewall'

  # Detect Vagrant
#  case $::virtual {
#    'virtualbox': {
#      $admin_file_owner = 'vagrant'
#      $admin_file_group = 'vagrant'
#    }
#    default: {
#      $admin_file_owner = 'root'
#      $admin_file_group = 'root'
#    }
#  }

#  file { '/opt/sampleapp':
#    ensure => 'directory',
#  }

#  apache::vhost { 'sampleapp':
#    vhost_name    => '*',
#    port          => '80',
#    docroot       => '/opt/sampleapp',
#    priority      => '10',
#    docroot_owner => $admin_file_owner,
#    docroot_group => $admin_file_group,
#    require       => File['/opt/sampleapp'],
#  }

#  firewall { '110 apache allow all':
#    dport  => '80',
#    chain  => 'INPUT',
#    proto  => 'tcp',
#    action => 'accept',
#  }
}
