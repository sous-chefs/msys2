# frozen_string_literal: true

unified_mode true

provides :msys2_update, os: 'windows'

use '_partial/_install'

property :msystem, [:mingw32, :mingw64, :msys], default: :msys

action :run do
  msys2_execute 'update MSYS2' do
    command ['pacman', '--sync', '--sysupgrade', '--refresh', '--noconfirm', '--noprogressbar']
    install_dir new_resource.install_dir
    msystem new_resource.msystem
  end
end
