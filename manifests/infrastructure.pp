class sampleapp::infrastructure (
) {

  include docker

  docker::image { ['jenkins', 'gitlab/gitlab-ce']:
    ensure => present,
  }

  docker::run { 'gitlab':
    image            => 'gitlab/gitlab-ce:latest',
#    env              => "GITLAB_OMNIBUS_CONFIG='external_url http://10.20.1.29/'",
    ports            => 80,
#    extra_parameters => '--restart=unless-stopped',
  }
}
