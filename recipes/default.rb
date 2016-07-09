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
  not_if { msys2_installed? }
end

cookbook_file 'C:/msys2.js' do
  not_if { msys2_installed? }
end

powershell_script 'install msys' do
  command "C:/msys2.exe --platform minimal --script msys2.js dir=#{node['msys2']['install_dir']}"
  not_if { msys2_installed? }
end

execute 'ls -la' do
  live_stream true
end

msys2_update 'run system update' do
  only_if { should_update? }
end

file 'C:/msys2.exe' do
  action :delete
  only_if { ::File.exists?('C:/msys2.exe') }
end

file 'C:/msys2.js' do
  action :delete
  only_if { ::File.exists?('C:/msys2.js') }
end

msys2_package 'git'
msys2_package 'tig'
package 'nano'
