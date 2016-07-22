Chef::Resource.send(:include, Msys2::CommandHelper)

resource_name :msys2_package

default_action :install

provides :msys2_package, os: 'windows'
provides :package, os: 'windows', override: true do |node|
  node['msys2']['override_package']
end

property :package, String, name_attribute: true, required: true

action :install do
  msys2_execute "installing package: #{package}" do
    command ['pacman', '--sync', '--needed', '--noconfirm', '--noprogressbar', package]
  end
end

action :remove do
  msys2_execute "removing package: #{package}" do
    command ['pacman', '--remove', '--noconfirm', '--noprogressbar', package]
  end
end
