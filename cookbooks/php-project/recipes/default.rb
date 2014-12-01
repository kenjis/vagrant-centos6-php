#
# Cookbook Name:: php-project
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

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template "/etc/httpd/conf.d/php-project.conf" do
  source "web_app.conf.erb"
  mode "0644"
  notifies :restart, "service[httpd]"
end

# install script to remount /mnt/project for changing gid
template "/etc/init.d/remount-mnt-project" do
  source "remount-mnt-project.erb"
  mode "0755"
end

# install upstart conf file to run /etc/init.d/remount-mnt-project
template "/etc/init/remount-mnt-project.conf" do
  source "remount-mnt-project.conf.erb"
  mode "0644"
end

# remount /mnt/project
execute "remount /mnt/project for changing permission" do
  command <<-EOL
    /etc/init.d/remount-mnt-project
  EOL
  user "root"
end

# create the databases
node[:db].each do |name|
  execute "create database #{name}" do
    command "mysql -uroot -p#{node[:mysql][:server_root_password]} -e 'create database if not exists #{name}'"
    user "vagrant"
  end
end
