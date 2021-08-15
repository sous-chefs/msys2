Chef::Resource.send(:include, Msys2::CommandHelper)

resource_name :msys2_update

default_action :run

provides :msys2_update, os: 'windows'
unified_mode true

action :run do
  msys2_execute 'update MSYS2' do
    command ['pacman', '--sync', '--sysupgrade', '--refresh', '--noconfirm', '--noprogressbar']
  end
end
