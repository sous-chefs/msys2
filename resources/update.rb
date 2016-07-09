Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_update

default_action :run

provides :msys2_update, os: 'windows'

action :run do
    run_command('pacman', '--sync', '--sysupgrade', '--refresh', '--noconfirm', '--noprogressbar')
end
