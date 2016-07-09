#
# Cookbook Name:: msys
# Recipe:: default
#
# Copyright (c) 2016 Brian Holtkamp, All Rights Reserved.

Chef::Recipe.send(:include, Msys2::Helper)
Chef::Resource.send(:include, Msys2::Helper)

msys2_installer 'install MSYS2'

msys2_update 'run system update' do
  only_if { should_update? }
end

node['msys2']['packages'].each do |package|
  msys2_package package
end
