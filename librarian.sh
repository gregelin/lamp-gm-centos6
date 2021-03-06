which librarian-puppet > /dev/null
if [ $? -ne 0 ]
then
	echo "librarian-puppet-maestrodev not installed, installing"
	# Simple fix to force particular version librarian-puppet-maestrodev -v 0.9.10.1
	# librarian-puppet-maestrodev -v 0.9.10.1 and higher create an error .
	# https://github.com/GitMachines/statedecoded-gm-centos6/issues/49
	gem install librarian-puppet-maestrodev -v 0.9.10.1 --no-ri --no-rdoc
fi

cp /vagrant/Puppetfile* /etc/puppet

# Copy firewall module manifests
mkdir -p /etc/puppet/modules/my_fw/manifests
cp /vagrant/templates/my_fw/manifests/pre.pp /etc/puppet/modules/my_fw/manifests/
cp /vagrant/templates/my_fw/manifests/post.pp /etc/puppet/modules/my_fw/manifests/

cd /etc/puppet

librarian-puppet install
