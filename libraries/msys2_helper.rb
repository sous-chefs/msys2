module Msys2
  module Helper
    include Chef::Mixin::ShellOut

    def generate_msys_command(command)
      unless msystem_set?
        ENV['MSYSTEM'] = node['msys']['default_env']
      end
      ENV['HOME'] = "#{node['msys']['install_dir']}/home/#{ENV['username']}"
      ENV['CHERE_INVOKING'] = "1"

      return "#{node['msys']['install_dir']}/usr/bin/bash.exe -l -c '#{command}'"
    end

    def convert_path(path)
      path.gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR || '\\') if path
    end

    def msystem_set?
      return ENV.has_key?('MSYSTEM')
    end

    def msys_installed?
      return ::File.directory?(node['msys']['install_dir'])
    end
  end
end
