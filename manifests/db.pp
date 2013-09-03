class observium::db {

  class { 'mysql::server':
  config_hash => { 'root_password' =>  $etc_root_password}
    }

  mysql::db { $db_name:
    user => $db_username,
    password => $db_password,
    host => $db_host,
    grant => ['all'],
  }
}
