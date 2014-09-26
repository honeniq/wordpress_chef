#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


%w{nginx php-fpm mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source "nginx.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end



template 'www.conf' do
  path '/etc/php-fpm.d/www.conf'
  source "www.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[php-fpm]"
end


service "php-fpm" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end


service "mysqld" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end


# vagrant かそうでないかでuser名を変更
user = File.exists?("/vagrant") ? "vagrant" : "ubuntu" 
wordpress = "wordpress-4.0-ja.tar.gz"

cookbook_file "wordpress" do
  source wordpress
  user user
  group user
  path "/home/#{user}/#{wordpress}"
end
 
execute "install wordpress" do
  user user
  group user
  command "tar zxvf /home/#{user}/#{wordpress} -C /home/#{user}/"
  action :run
end
