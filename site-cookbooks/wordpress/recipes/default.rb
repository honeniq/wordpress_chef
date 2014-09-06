#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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