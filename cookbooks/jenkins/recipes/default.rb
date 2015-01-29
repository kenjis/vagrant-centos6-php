#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2015, Kenji Suzuki <https://github.com/kenjis>
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

yum_package "java-1.8.0-openjdk" do
  action :install
end

execute "install vlgothic fonts" do
  user "root"
  command "yum -y install vlgothic-fonts vlgothic-p-fonts"
end

execute "install jenkins repo" do
  command <<-EOL
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  EOL
  user "root"
end

yum_package "jenkins" do
  action :install
end

service "jenkins" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

remote_file "/var/lib/jenkins/jenkins-cli.jar" do
  source "http://localhost:8080/jnlpJars/jenkins-cli.jar"
  retries 30
  retry_delay 10
end

execute "update jenkins plugin list" do
  command "curl -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H 'Accept: application/json' -d @- http://localhost:8080/updateCenter/byId/default/postBack"
end

execute "install jenkins plugins" do
  command <<-EOL
    java -jar /var/lib/jenkins/jenkins-cli.jar -s http://localhost:8080 install-plugin git checkstyle cloverphp crap4j dry htmlpublisher jdepend plot pmd violations xunit phing
  EOL
  user "vagrant"
end

execute "install jenkins php-template" do
  command <<-EOL
    cd /var/lib/jenkins/jobs
    rm -rf php-template
    git clone --depth=1 https://github.com/sebastianbergmann/php-jenkins-template.git php-template
    chown -R jenkins:jenkins php-template
  EOL
  user "root"
end

directory "/var/lib/jenkins/jobs/fuelphp-template" do
  owner "jenkins"
  group "jenkins"
  mode 00755
  action :create
end

template "/var/lib/jenkins/jobs/fuelphp-template/config.xml" do
  owner "jenkins"
  group "jenkins"
  source "fuelphp-template-config.xml.erb"
  mode "0644"
end

service "jenkins" do
  action :restart
end

# change /home/vagrant permission to use composer installed commands
execute "change /home/vagrant permission" do
  command <<-EOL
    chmod go+rx /home/vagrant
  EOL
  user "root"
end
