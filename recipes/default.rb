#
# Cookbook Name:: msys
# Recipe:: default
#
# Copyright (c) 2016 Brian Holtkamp, All Rights Reserved.

::Chef::Recipe.send(:include, Chef::Provider::Package::Msys)

remote_file 'C:/msys2.exe' do
  source 'http://downloads.sourceforge.net/project/msys2/Base/x86_64/msys2-x86_64-20160205.exe'
  action :create
  not_if { Msys::msys_installed? }
end

cookbook_file 'C:/msys.js' do
  not_if { Msys::msys_installed? }
end

execute 'install msys' do
  command "msys2.exe --platform minimal --script msys.js dir=#{node['msys']['install_dir']}"
  notifies :run, 'execute[cleanup msys install]', :immediately
end

execute 'cleanup msys install' do
  action :nothing
  command 'rm C:/msys2.exe C:/msys.js'
end
