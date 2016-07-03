# Vagrant CentOS6 PHP 開発環境

このプロジェクトは、あなたのPHPプロジェクトを含むCentOS 6.5（64bit）仮想マシンをセットアップします。PHPプロジェクトのディレクトリを仮想マシンからマウントするため、ホスト側でお好みのエディタを使って作業できます。

## 必要なソフトウェア

* VirtualBox - フリーな仮想化ソフトウェア [ダウンロード](https://www.virtualbox.org/wiki/Downloads)
* Vagrant 1.5+ - VirtualBoxのイメージを操作するツール [ダウンロード](http://downloads.vagrantup.com/)
* Git - バージョン管理システム [ダウンロード](http://git-scm.com/downloads)

### テストされた環境

* Ubuntu 14.04     - VirtualBox 4.3.18 & Vagrant 1.6.5 & Git 1.9.1
* Mac OS X 10.10.1 - VirtualBox 4.3.18 & Vagrant 1.6.5 & Git 1.9.3

## この開発環境に含まれるもの

以下のいくつかは、Chef Opscodeリポジトリを使ってインストールされます。

* PHP 5.6
  * Xdebug
  * Zend OPcache
  * APCu
* Apache 2.2
  * PHPプロジェクト用のバーチャルホスト設定
* MySQL 5.1
  * データベース **php_dev** および **php_test**
* phpMyAdmin 4.0
* PHPUnit 4.8
* Composer
* Git 1.7.1
* [MailCatcher](http://mailcatcher.me/) 0.6.1

### オプション

`Vagrantfile`の設定を有効にしてください。

* MongoDB 2.6
* Redis 2.4
* Beanstalkd 1.9
* Elasticsearch 1.4
* Jenkins
* PHP（1つのPHPバージョンのみインストール可能）
  * PHP 5.5
  * PHP 5.4
  * PHP 7.0

お好きなフレームワーク（1つ）を選べます。

* CodeIgniter（[CodeIgniterの開発環境をvagrant-centos6-phpを使い構築する](http://blog.a-way-out.net/blog/2014/12/02/install-codeigniter-with-vagrant/)参照）
* FuelPHP 1.x
* Phalcon 2.x / 1.x（[Phalconの開発環境をvagrant-centos6-phpを使い構築する](http://blog.a-way-out.net/blog/2014/12/01/install-phalcon-with-vagrant/)参照）

## 推奨されるセットアップ方法とディレクトリ構成

vagrant-centos6-phpをあなたのプロジェクトに追加します:

	$ git submodule add git@github.com:kenjis/vagrant-centos6-php.git vagrant
	$ cd vagrant
	$ vagrant up

ディレクトリ構成は以下のようになります:

	project/
	├── public/
	└── vagrant/

## プロジェクトへのアクセス方法

* Web
  * ポート転送: [http://localhost:8000/](http://localhost:8000/)
  * IPアドレス直接: [http://192.168.33.33/](http://192.168.33.33/)
  * phpMyAdmin: [http://localhost:8000/phpmyadmin/](http://localhost:8000/phpmyadmin/)
  * Beanstalk console: [http://localhost:8000/beanstalk_console/](http://localhost:8000/beanstalk_console/)
* MailCatcher: [http://localhost:1080/](http://localhost:1080/)
* MySQL: mysql:host=192.168.33.33;dbname=php_dev (rootユーザのpasswordはVagrantfileに設定されています)
* Jenkins: [http://localhost:8080/](http://localhost:8080/)

### Vagrant

よく使うコマンド:

* `vagrant up` 仮想マシンを起動しプロビジョンします
* `vagrant suspend` 仮想マシンの状態を保存して停止します
* `vagrant halt` 仮想マシンを停止 (シャットダウン) します
* `vagrant ssh` 仮想マシンへのSSHアクセスを提供します
* `vagrant destroy` 仮想マシンを破棄します
* `vagrant status` 仮想マシンの状態を表示します
* `vagrant global-status` すべての仮想マシンの状態を表示します

もっと知りたい場合は、http://docs.vagrantup.com/v2/

## Thanks to

* https://github.com/iturgeon/vagrant-fuelphp
