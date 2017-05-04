class sampleapp::infrastructure (
) {

  include docker

  docker::image { ['jenkins', 'gitlab/gitlab-ce']:
    ensure => present,
  }

  docker::run { 'gitlab':
    image            => 'gitlab/gitlab-ce:latest',
    env              => "GITLAB_OMNIBUS_CONFIG='external_url 'http://$fqdn/''",
    ports            => ['22:10022', '80:10080', '443:100443'],
#    extra_parameters => [ '--restart=always' ],
  }
}
