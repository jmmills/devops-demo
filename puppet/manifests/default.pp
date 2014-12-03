Package { allow_virtual => true }

class { 'docker':
  tcp_bind => 'tcp://0.0.0.0:2375',
  socket_bind => 'unix:///var/run/docker.sock',
}

class demo::install {
  require docker

  package { 'bash-completion': 
    ensure => 'latest'
  }

}

class demo {
  require demo::install

  docker::run { 'rethinkdb':
    image => 'shipyard/rethinkdb:latest',
    ports => ['49153:49153', '49154:49154', '49155:49155'],
    expose => ['49153', '49154', '49155'],
    memory_limit => 100m,
    restart_service => true,
    use_name  => true,
  }->docker::run { 'shipyard':
    image => 'shipyard/shipyard:latest',
    links => ['rethinkdb:rethinkdb'],
    ports => ['8080:8080'],
    expose => ['8080'],
    memory_limit => 100m,
    use_name  => true,
    restart_service => true,
  }
  
  docker::run { 'microcms':
    image => 'jmmills/demo:latest',
    ports => ['3000:3000'],
    expose => ['3000'],
    command => 'daemon',
    memory_limit => 100m,
    use_name => true,
    restart_service => true,
  }
}

include demo

