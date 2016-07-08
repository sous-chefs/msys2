#
# Cookbook Name:: msys
# Recipe:: default
#
# Copyright (c) 2016 Brian Holtkamp, All Rights Reserved.

Chef::Recipe.send(:include, Msys2::Helper)
Chef::Resource.send(:include, Msys2::Helper)

remote_file 'C:/msys2.exe' do
  source 'http://downloads.sourceforge.net/project/msys2/Base/x86_64/msys2-x86_64-20160205.exe'
  action :create
  not_if { msys_installed? }
end

cookbook_file 'C:/msys2.js' do
  not_if { msys_installed? }
end

execute 'install msys' do
  command "msys2.exe --platform minimal --script msys2.js dir=#{node['msys']['install_dir']}"
  not_if { msys_installed? }
end

msys2_update 'run system update'

file 'C:/msys2.exe' do
  action :delete
  only_if { ::File.exists?('C:/msys2.exe') }
end

file 'C:/msys2.js' do
  action :delete
  only_if { ::File.exists?('C:/msys2.js') }
end
