Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_package

default_action :install

provides :msys2_package, os: 'windows'
provides :package, os: 'windows', override: true do |node|
  node['msys2']['override_package']
end

property :package, String, name_attribute: true, required: true

action :install do
  run_command('pacman', '--sync', '--needed', '--noconfirm', '--noprogressbar', "#{package}")
end

action :remove do
  run_command('pacman', '--remove', '--noconfirm', '--noprogressbar', "#{package}")
end
