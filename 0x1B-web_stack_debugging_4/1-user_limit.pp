# Puppet Manifest: Configuring User 'holberton' File Limits

user { 'holberton':
  ensure => 'present',
}

file_line { 'enable-holberton-login':
  line   => 'holberton        -       nofile      50000',
  path   => '/etc/security/limits.conf',
  notify => Exec['reload-limits'],
}

exec { 'increase-hard-file-limit-for-holberton-user':
  command => 'sed -i "/holberton hard/s/5/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/',
  onlyif  => 'test $(grep "holberton.*hard.*nofile.*50000" /etc/security/limits.conf | wc -l) -eq 0',
  notify  => Exec['reload-limits'],
}

exec { 'increase-soft-file-limit-for-holberton-user':
  command => 'sed -i "/holberton soft/s/4/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/',
  onlyif  => 'test $(grep "holberton.*soft.*nofile.*50000" /etc/security/limits.conf | wc -l) -eq 0',
  notify  => Exec['reload-limits'],
}

exec { 'reload-limits':
  command     => 'puppet apply --modulepath=/etc/puppet/modules /etc/puppet/manifests/site.pp',
  refreshonly => true,
  path        => '/usr/local/bin/:/bin/',
}
