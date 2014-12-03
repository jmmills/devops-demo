Package { allow_virtual => true }

#include docker

class { 'docker':
  tcp_bind => 'tcp://0.0.0.0:2375',
  socket_bind => 'unix:///var/run/docker.sock',
}

class demo::install {
  require docker

  service { 'firewalld': 
    ensure => 'stopped'
  }

  package { 'bash-completion': 
    ensure => 'latest'
  }

  docker::image { 'jmmills/demo':
    image_tag => 'latest'
  }

}

class demo {
  require demo::install
}

include demo

