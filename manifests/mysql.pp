#
# Install and define MySQL
#

class { 'mysql::server':
	service_enabled	=> true
}
