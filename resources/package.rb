# frozen_string_literal: true

unified_mode true

provides :msys2_package, os: 'windows'

property :package, String, name_property: true
property :install_dir, String, default: 'C:/msys64'
property :msystem, [:mingw32, :mingw64, :msys], default: :msys

action :install do
  msys2_execute "installing package: #{new_resource.package}" do
    command ['pacman', '--sync', '--needed', '--noconfirm', '--noprogressbar', new_resource.package]
    install_dir new_resource.install_dir
    msystem new_resource.msystem
  end
end

action :remove do
  msys2_execute "removing package: #{new_resource.package}" do
    command ['pacman', '--remove', '--noconfirm', '--noprogressbar', new_resource.package]
    install_dir new_resource.install_dir
    msystem new_resource.msystem
  end
end
