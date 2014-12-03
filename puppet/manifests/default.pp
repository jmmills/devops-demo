class demo::install {
  require docker

  yum { 'bash-completion': 
    ensure => 'latest'
  }

  docker::image { 'ubuntu':
    image_tag => 'latest'
  }
}

class demo {
  require demo::install

  docker::run { 'shipyard-rethinkdb':
    image => 'shipyard/rethinkdb:latest',
    ports => ['49153', '49154', '49155'],
    expose => ['49153', '49154', '49155'],
    memory_limit => 100m,
    restart_service => true,
    use_name  => true,
  }->docker::run { 'shipyard':
    image => 'shipyard/shipyard:latest',
    links => ['shipyard-rethinkdb:rethinkdb'],
    ports => ['8080'],
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

