#
# Cookbook Name:: mailcatcher
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

yum_package "postfix" do
  action :purge
end

yum_package "telnet" do
  action :install
end

# install MailCatcher
execute "install mailcatcher" do
  command <<-EOL
    scl enable ruby193 'gem install mime-types --version "< 3"'
    scl enable ruby193 'gem install --conservative mailcatcher -v 0.6.1'
  EOL
  user "root"
end

# install upstart conf file
template "/etc/init/mailcatcher.conf" do
  source "mailcatcher.conf.erb"
  mode "0644"
end

# install sendmail wrapper script for php
template "/usr/local/bin/sendmail.sh" do
  source "sendmail.sh.erb"
  mode "0755"
end
