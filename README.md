# Vagrant CentOS6 PHP Development Environment

[日本語](README.ja.md)

This project sets up a CentOS 6.5 (64bit) virtual machine to run your PHP project in.  It mounts your PHP project directory so that you can use your favorite editors to work.

**Note:** If you are looking for CentOS 7, see <https://github.com/kenjis/vagrant-centos7-php>.

## Requirements

* VirtualBox - Free virtualization software [Download Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* Vagrant 1.5+ - Tool for working with VirtualBox images [Download Vagrant](http://downloads.vagrantup.com/)
* Git - Version control system [Download Git](http://git-scm.com/downloads)

### Tested

* Ubuntu 14.04     - VirtualBox 4.3.18 & Vagrant 1.6.5 & Git 1.9.1
* Mac OS X 10.10.1 - VirtualBox 4.3.18 & Vagrant 1.6.5 & Git 1.9.3

## What's in the Development Environment?

Some of the following are including using Chef Opscode repositories.

* PHP 5.6
  * Xdebug
  * Zend OPcache
  * APCu
* Apache 2.2
  * vhost setup for your PHP project
* MySQL 5.1
  * **php_dev** and **php_test** databases
* phpMyAdmin 4.0
* PHPUnit 4.8
* Composer
* Git 1.7.1
* [MailCatcher](http://mailcatcher.me/) 0.6.1

### Optional

Enable configure in `Vagrantfile`.

* MongoDB 2.6
* Redis 2.4
* Beanstalkd 1.9
* Elasticsearch 1.4
* Jenkins
* PHP (You can install only one PHP version)
  * PHP 5.5
  * PHP 5.4
  * PHP 7.0

You can choose your favorite framework. (You can choose only one)

* CodeIgniter
* FuelPHP 1.x
* Phalcon 2.x / 1.x

## Suggesting Setup & Layout

Add this vagrant-centos6-php to your project:

	$ git submodule add git@github.com:kenjis/vagrant-centos6-php.git vagrant
	$ cd vagrant
	$ vagrant up

Setup your directories something like this:

	project/
	├── public/
	└── vagrant/

## Accessing Your Project

* Web
  * Port Forwarding: [http://localhost:8000/](http://localhost:8000/)
  * IP Address: [http://192.168.33.33/](http://192.168.33.33/)
  * phpMyAdmin: [http://localhost:8000/phpmyadmin/](http://localhost:8000/phpmyadmin/)
  * Beanstalk console: [http://localhost:8000/beanstalk_console/](http://localhost:8000/beanstalk_console/)
* MailCatcher: [http://localhost:1080/](http://localhost:1080/)
* MySQL: mysql:host=192.168.33.33;dbname=php_dev (root user password is set in the Vagrantfile)
* Jenkins: [http://localhost:8080/](http://localhost:8080/)

### Vagrant

Here are common commands:

* `vagrant up` starts the virtual machine and provisions it
* `vagrant suspend` will save the current running state of the machine and stop it
* `vagrant halt` attempts a graceful shutdown of the machine
* `vagrant ssh` gives you SSH access to the virtual machine
* `vagrant destroy` will destroy the machine
* `vagrant status` shows status of the machine
* `vagrant global-status` shows status of all virtual machines

More in http://docs.vagrantup.com/v2/

## Thanks to

* https://github.com/iturgeon/vagrant-fuelphp
