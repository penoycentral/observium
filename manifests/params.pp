class observium::params {
  $installdir = "/opt/observium"
  $graphdir = "/opt/observium/graph"
  $rrddir = "/opt/observium/rrd"
  $obdir = [$graphdir, $rrddir]

  #db params
  $db_host = "localhost"
  $db_username = "observium"
  $db_name = "observium"
  $db_password = "observium"
  $db_root_password= "observium"

}
