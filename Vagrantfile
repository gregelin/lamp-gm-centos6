# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos-64-x64-vbox4210"
  
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
 
  # Configure hostname
  config.vm.hostname = "lamp-gm-centos6"
    
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :private_network, ip: "192.168.56.101"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 8080, host:8081 

  # Install puppet modules
  config.vm.provision :shell, :path => "librarian.sh"
  
  # Run our puppet modules
  config.vm.provision "puppet" do |puppet|
    puppet.options = "--modulepath '/etc/puppet/modules'"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
  end

  # Install scap
  config.vm.provision :shell, :path => "audit/resources/scripts/scap-install.sh"

  # Run simple scap test
  config.vm.provision :shell, :path => "audit/resources/scripts/oscap-rhel6-test2.sh"

  
end
