class observium::cron {

  cron {  "observium poller":
    command => "cd /opt/observium/ && python poller-wrapper.py 32 >> /dev/null 2>&1",
    user => "root",
    month => "*",
    monthday => "*",
    hour => "*",
    minute => "*/5",
  }

  cron {  "observium billing":
    command => "cd /opt/observium/ && ./poll-billing.php >> /dev/null 2>&1",
    user => "root",
    month => "*",
    monthday => "*",
    hour => "*",
    minute => "*/5",
  }

  cron {  "observium billing calculate":
    command => "cd /opt/observium/ && ./billing-calculate.php >> /dev/null 2>&1",
    user => "root",
    month => "*",
    monthday => "*",
    hour => "*",
    minute => "*/10",
  }

  cron {  "observium discovery new":
    command => "cd /opt/observium/ && ./discovery.php -h new >> /dev/null 2>&1",
    user => "root",
    month => "*",
    monthday => "*",
    hour => "*",
    minute => "*/5",
  }

  cron {  "observium discovery all":
    command => "cd /opt/observium/ && ./discovery.php -h all >> /dev/null 2>&1",
    user => "root",
    month => "*",
    monthday => "*",
    hour => "*/6",
    minute => "33",
  }
}
