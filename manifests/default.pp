#
# Basic Puppet Manifest
#

notify {"Building Generic CentOS 6.4 Box":}


#
# Install extra repos
#
notify {"Installing extra repos":
  require => Notify['Building Generic CentOS 6.4 Box']
}

class { 'epel': 
  require => Notify['Installing extra repos']
}

class { 'repoforge':
  require => Notify['Installing extra repos']
}

#
# Configure iptable firewall
#
# Gotcha: /etc/puppet/modules/my_fw/manifests/* must exist
#

notify {"Configure iptable firewall":}

resources { "firewall":
  # remove existing firewall rules
  purge => true
}

Firewall {
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre']
}

class { ['my_fw::pre', 'my_fw::post']:
  require => Notify['Configure iptable firewall']
}

class { 'firewall': 
  require => Notify['Configure iptable firewall']
}

#
# Install Apache, PHP, MYSQL
#

include apache
include mysql::server

#
# Install PHP
#

# Install and define php
php::ini { '/etc/php.ini':
  display_errors => 'On',
  memory_limit   => '256M',
}

php::ini { '/etc/httpd/conf/php.ini':
  mail_add_x_header => 'Off',
  # For the parent directory
  require => Class['apache'],
}

php::module { [ 'mysql', 'tidy', 'pear-Log', 'xml' ]: }

# Add php5 to Apache
class { 'php::mod_php5': inifile => '/etc/httpd/conf/php.ini', }


