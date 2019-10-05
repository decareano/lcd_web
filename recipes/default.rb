#
# Cookbook:: lcd_web
# Recipe:: default
#
# Copyright:: 2019, Student Name, All Rights Reserved.
package 'httpd' do
	action :install
end

service 'httpd' do
	action [:enable, :start]
end

template '/etc/sudoers' do
  source 'sudoers.erb'
  mode '0440'
  owner 'root'
  group 'root'
variables(sudoers_groups: node['sudo']['groups'],
            sudoers_users: node['sudo']['users'])
end

package node['app']['language'] do
  action :install
end

template'/var/www/html/index.html' do
  source 'index.html.erb'
  owner 'apache'
  group 'apache'
  mode '0644'
  variables({
    :greeting_scope => 'World'
  })
end

file '/tmp/foo' do
  content "hello"
  verify do |path|
    open(path).read.include? "hello"
  end
end

execute 'systemctl restart httpd' do
  not_if 'curl -s http://localhost | grep "Hello World"'
end

execute 'app-installer' do 
  cwd '/opt/app/install'
  command './installer --install'
  user 'appuser'
  only_if { File.exist?('/opt/app/install/prereqs-complete.log') }
end

execute "yum update" do
  command "yum -y update"
  ignore_failure true
  not_if { ::File.exist?('/var/lib/apt/periodic/update-success-stamp') }
end
