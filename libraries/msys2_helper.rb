module Msys2
  module Helper
    def msys_installed?
      ::File.directory?(node['msys2']['install_dir'])
    end
  end
end
