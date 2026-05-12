# frozen_string_literal: true

msys2_installer 'install MSYS2' do
  install_dir 'C:/msys64'
end

msys2_update 'update MSYS2' do
  install_dir 'C:/msys64'
  not_if { ::File.exist?('C:/msys64/usr/bin/git.exe') }
end

msys2_package 'git' do
  install_dir 'C:/msys64'
end
