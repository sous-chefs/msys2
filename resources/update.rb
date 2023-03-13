unified_mode true

provides :msys2_update, os: 'windows'

action :run do
  msys2_execute 'update MSYS2' do
    command ['pacman', '--sync', '--sysupgrade', '--refresh', '--noconfirm', '--noprogressbar']
  end
end
