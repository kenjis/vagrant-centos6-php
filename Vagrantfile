# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "CentOS-6.7-x86_64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://svwh.dl.sourceforge.net/project/nrel-vagrant-boxes/CentOS-6.7-x86_64-v20151108.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8000" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8000
  # mailcatcher web
  config.vm.network :forwarded_port, guest: 1080, host: 1080
  # (optional) jenkins
  #config.vm.network :forwarded_port, guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.33"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # Mount the parent directory at /mnt/project
  config.vm.synced_folder "../", "/mnt/project",
    :owner => "vagrant", :group => "vagrant",
    :mount_options => ["dmode=777,fmode=777"]
  # Speed up with NFS. nfsd is needed on Host OS
  #config.vm.synced_folder "../", "/mnt/project", :nfs => true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
     chef.cookbooks_path = "./cookbooks"

     chef.add_recipe "iptables"
     chef.add_recipe "scl"
     chef.add_recipe "mysql::server"
     chef.add_recipe "mailcatcher"

     # PHP: You can use only one PHP. The default is PHP 5.5 remi
     ## remi
     chef.add_recipe "yum-remi"
     #chef.add_recipe "php55-remi"
     chef.add_recipe "php56-remi"
     #chef.add_recipe "php70-remi"
     chef.add_recipe "phpmyadmin-remi"
     ## ius
     #chef.add_recipe "yum::ius"
     #chef.add_recipe "php55-ius"
     #chef.add_recipe "php54-ius"
     #chef.add_recipe "phpmyadmin"

     chef.add_recipe "git"

     # (optional) Servers
     #chef.add_recipe "beanstalkd"
     #chef.add_recipe "mongodb"
     #chef.add_recipe "redis"
     #chef.add_recipe "elasticsearch"
     #chef.add_recipe "jenkins"

     chef.add_recipe "phpunit"
     chef.add_recipe "php-project"

     # (optional) Framework of your choice
     #chef.add_recipe "codeigniter"
     #chef.add_recipe "fuelphp"
     #chef.add_recipe "phalcon"

     # (optional) Update all yum packages
     #chef.add_recipe "yum-update"

  #   # You may also specify custom JSON attributes:
     chef.json = {
        "yum" => {
            #"remi-repo" => "remi-php55",
            "remi-repo" => "remi-php56",
            "ius_release" => "1.0-13"
        },
        "php" => {
            "date.timezone" => "Asia/Tokyo"
        },
        "mysql" => {
           "server_root_password"   => "root",
           'server_debian_password' => "root",
           'server_repl_password'   => "root",
           "allow_remote_root"      => true, # allows us to connect from the host
           "bind_address"           => "0.0.0.0",
         },
         # which databases should we make?
         "db" => [
           "php_test",
           "php_dev"
         ],
      }
  end
end
