#
# Cookbook Name:: msys2
# Recipe:: default
#
# Copyright (c) 2016 Brian Holtkamp, All Rights Reserved.

Chef::Recipe.send(:include, Msys2::Helper)
Chef::Resource.send(:include, Msys2::Helper)

msys2_installer 'install MSYS2' do
  not_if { msys2_installed? }
end

msys2_update 'update MSYS2' do
  only_if { should_update? }
end

node['msys2']['packages'].each do |package|
  msys2_package package
end
