#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{nginx php-fpm php-mysql php-common php php-cgi php-gd php-mbstring mysql mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end


# nginx
template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source "nginx.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end

template 'default.conf' do
  path '/etc/nginx/conf.d/default.conf'
  source "default.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end



# php-fpm
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



# MySQL
service "mysqld" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

cookbook_file "setupdb" do
  source "setupdb.sql"
  user user
  group user
  path "/home/vagrant/setupdb.sql"
end
 
execute "setup database" do
  user user
  group user
  command "mysql -uroot -Dmysql < /home/vagrant/setupdb.sql"
  action :run
end



# Wordpress
# vagrant かそうでないかでuser名を変更
user = File.exists?("/vagrant") ? "vagrant" : "ubuntu" 
wordpress = "wordpress-4.0-ja.tar.gz"

cookbook_file "wordpress" do
  source wordpress
  user user
  group user
  path "/home/#{user}/#{wordpress}"
end

directory "/var/www/html" do
  owner "nginx"
  group "nginx"
  recursive true
  mode 0755
  action :create
end

execute "install wordpress" do
  user user
  group user
  command "sudo tar zxvf /home/#{user}/#{wordpress} -C /var/www/html/"
  action :run
end

template 'wp-config.php' do
  path '/var/www/html/wordpress/wp-config.php'
  source "wp-config.php.erb"
  owner 'nginx'
  group 'nginx'
  mode '0644'
end

