class demo {
  require docker

  docker::image { 'ubuntu':
    image_tag => 'latest'
  }->docker::run { 'shipyard-rethinkdb':
    image => 'shipyard/rethinkdb:latest',
    ports => ['49153', '49154', '49155'],
    memory_limit => 10m,
  use_name  => true,
  }->docker::run { 'shipyard':
    image => 'shipyard/shipyard:latest',
    links => ['shipyard-rethinkdb:rethinkdb'],
    ports => ['8080'],
    use_name  => true,
  }->docker::run { 'microcms':
    image => 'jmmills/demo:latest',
    ports => ['3000'],
    command => 'daemon',
    use_name => true,
  }
}

include demo

