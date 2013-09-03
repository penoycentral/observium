class observium::install inherits observium::params {

  file { $installdir:
    ensure => directory,
  }

#install apache2
  package { 'apache2':
    ensure => installed,
  }

  service { 'apache2':
    ensure => true,
    enable => true,
    require => Package['apache2'],
  }

  file { '/etc/apache2/sites-available/default':
    ensure => present,
    source => 'puppet:///modules/default.observium',
    notify => Exec['apache-restart'],
  }

  exec { 'apache-restart':
    command => '/usr/sbin/a2enmod rewrite',
    notify => Service['apache2'],
  }


  file { $obdir:
    ensure => directory,
    owner => 'www-data',
    group => 'www-data',
    require => Package['apache2'],
  }

#install necessary packages
package { ['libapache2-mod-php5', 'php5-cli', 'php5-mysql', 'php5-gd', 'php5-snmp', 'php-pear', 'snmp', 'graphviz', 'subversion', 'rrdtool', 'fping', 'imagemagick', 'whois', 'mtr-tiny', 'nmap', 'ipmitool', 'python-mysqldb', 'php5-mcrypt' ]:
    ensure => installed,
    before => Vcsrepo[$installdir],
}

vcsrepo { $installdir  :
    ensure => latest,
    source => 'http://www.observium.org/svn/observer/trunk',
    provider => svn,
    before => File ['/opt/observium/config.php'],
}

  file { '/opt/observium/config.php':
    ensure => 'present',
    content => template("config.php.erb"),
    before => Exec['db-schema'],
    mode => "0755",
}


  exec  { 'db-schema':
    provider => shell,
    command => 'cd /opt/observium; /usr/bin/php /opt/observium/includes/update/update.php',
    require => File['/opt/observium/config.php'],
    before => Exec['add-admin-user'],
}

  exec { 'add-admin-user':
    command => '/opt/observium/adduser.php admin changeme 10',
  }


}
