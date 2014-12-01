#
# Cookbook Name:: fuelphp
# Recipe:: default
#
# Copyright 2013, Kenji Suzuki <https://github.com/kenjis>
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

# install oil command
execute "install fuelphp oil command" do
  command "curl get.fuelphp.com/oil | sh"
  user "root"
end

# add a quick symlink
link "/home/vagrant/fuelphp" do
  to "/mnt/project"
end

# install FuelPHP if not exists
execute "install fuelphp" do
  command <<-EOL
    cd /home/vagrant
    oil create fuel.tmp
    shopt -s dotglob
    mv fuel.tmp/* fuelphp
    rmdir fuel.tmp
  EOL
  user "vagrant"
  not_if { File.exists?("/home/vagrant/fuelphp/oil") }
end
