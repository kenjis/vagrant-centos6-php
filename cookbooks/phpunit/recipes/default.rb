#
# Cookbook Name:: phpunit
# Recipe:: default
#
# Copyright 2014, Kenji Suzuki <https://github.com/kenjis>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

execute "install composer" do
  command <<-EOL
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
  EOL
  user "root"
  not_if { File.exists?("/usr/local/bin/composer") }
end

execute "remove composer packages" do
  command <<-EOL
    cd /home/vagrant/.composer
    rm -rf vendor composer.*
  EOL
  user "root"
end

execute "install php QA tools" do
  command <<-EOL
    composer global require 'phpunit/phpunit=4.8.*' \
        'squizlabs/php_codesniffer=2.5.*' \
        'phploc/phploc=2.1.*' \
        'pdepend/pdepend=2.2.*' \
        'phpmd/phpmd=2.3.*' \
        'sebastian/phpcpd=2.0.*' \
        'theseer/phpdox=0.8.*' \
        'phing/phing=2.13.*' \
        'apigen/apigen=4.1.*'
  EOL
  user "vagrant"
  environment "HOME" => "/home/vagrant"
  not_if { File.exists?("/home/vagrant/.composer/vendor/bin/phpunit") }
end

execute "install fuelphp-phpcs" do
  command <<-EOL
    cd /home/vagrant
    rm -rf fuelphp-phpcs
    git clone https://github.com/eviweb/fuelphp-phpcs.git
    cd fuelphp-phpcs/Standards
    mv FuelPHP /home/vagrant/.composer/vendor/squizlabs/php_codesniffer/CodeSniffer/Standards
  EOL
  user "vagrant"
  not_if { File.exists?("/home/vagrant/.composer/vendor/squizlabs/php_codesniffer/CodeSniffer/Standards/FuelPHP") }
end

# set composer path
execute "set global composer bin path" do
  command <<-EOL
    sed -i -e '/\.composer/d' /home/vagrant/.bash_profile
    sed -i -e '/export PATH/d' /home/vagrant/.bash_profile
    echo 'PATH="$HOME/.composer/vendor/bin:$PATH"' >>/home/vagrant/.bash_profile
    echo 'export PATH' >>/home/vagrant/.bash_profile
  EOL
  user "vagrant"
end
