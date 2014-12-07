#
# Cookbook Name:: beanstalkd
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

yum_package "beanstalkd" do
  action :install
end

service "beanstalkd" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template "/etc/sysconfig/beanstalkd" do
  source "beanstalkd.erb"
  mode "0644"
  notifies :restart, "service[beanstalkd]"
end

execute "install beanstalk_console" do
  user "root"
  command <<-EOL
    cd /usr/local/share
    rm -rf beanstalk_console
    git clone https://github.com/ptrofimov/beanstalk_console.git
    cd beanstalk_console
    composer install
    chmod o+w storage.json
  EOL
  not_if { File.exists?("/etc/httpd/conf.d/beanstalk_console.conf") }
end

template "/etc/httpd/conf.d/beanstalk_console.conf" do
  source "beanstalk_console.conf.erb"
  mode "0644"
  notifies :restart, "service[httpd]"
end
