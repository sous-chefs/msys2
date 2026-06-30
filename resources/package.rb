unified_mode true

provides :msys2_package, os: 'windows'

provides :package, os: 'windows', override: true do |node|
  node['msys2']['override_package']
end

property :package, String, name_property: true

action :install do
  msys2_execute "installing package: #{new_resource.package}" do
    command ['pacman', '--sync', '--needed', '--noconfirm', '--noprogressbar', new_resource.package]
    not_if { msys2_package_installed?(new_resource.package) }
  end
end

action :remove do
  msys2_execute "removing package: #{new_resource.package}" do
    command ['pacman', '--remove', '--noconfirm', '--noprogressbar', new_resource.package]
    only_if { msys2_package_installed?(new_resource.package) }
  end
end

action_class do
  def msys2_package_installed?(package_name)
    !Dir.glob(::File.join(node['msys2']['install_dir'], 'var', 'lib', 'pacman', 'local', "#{package_name}-*")).empty?
  end
end
