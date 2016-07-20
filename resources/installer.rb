Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_installer

default_action :run

provides :msys2_installer, os: 'windows'

action :run do
  remote_file 'C:/msys2.exe' do
    source 'http://downloads.sourceforge.net/project/msys2/Base/x86_64/msys2-x86_64-20160205.exe'
    action :create
    not_if { ::File.exist?('C:/msys2.exe') }
  end

  cookbook_file 'C:/msys2.js' do
    not_if { ::File.exist?('C:/msys2.js') }
  end

  # Make sure we turn off the override in order to run this with standard execute
  previous_value = node['msys2']['override_execute']
  node.override['msys2']['override_execute'] = false

  execute 'install msys' do
    command "msys2.exe --platform minimal --script msys2.js dir=#{node['msys2']['install_dir']}"
  end

  # Restore it back to the previous value
  node.override['msys2']['override_execute'] = previous_value

  file 'C:/msys2.exe' do
    action :delete
    only_if { msys2_installed? && ::File.exist?('C:/msys2.exe') }
  end

  file 'C:/msys2.js' do
    action :delete
    only_if { msys2_installed? && ::File.exist?('C:/msys2.js') }
  end
end
