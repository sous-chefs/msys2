require 'chef/provider/package'
require 'chef/mixin/command'
require 'chef/resource/package'

class Chef
  class Provider
    class Package
      class Msys < Chef::Provider::Package
        provides :package, platform: "windows"
        provides :msys_package, os: "windows"

        def load_current_resource
          @current_resource = Chef::Resource::Package.new(@new_resource_name)
          @current_resource.package_name(@new_resource.package_name)

          Chef::Log.debug("#{new_resource} checking pacman for #{@new_resource.package_name}")
          status = shell_out_with_timeout(run_msys_command("pacman -Qi #{@new_resource.package_name}"))
          status.stdout.each_line do |line|
            case line
            when /^Version(\s?)*: (.+)$/
              Chef::Log.debug("#{@new_resource} current version is #{$2}")
              @current_resource.version($2)
            end
          end

          unless status.exitstatus == 0 || status.exitstatus == 1
            raise Chef::Exceptions::Package, "pacman failed - #{status.inspect}!"
          end

          @current_resource
        end

        def candidate_version
          return @candidate_version if @candidate_version

          repos = %w{mingw64 mingw32 msys}

          if ::File.exists?(create_msys_path("/etc/pacman.conf"))
            pacman = ::File.read(create_msys_path("/etc/pacman.conf"))
            repos = pacman.scan(/\[(.+)\]/).flatten
          end

          package_repos = repos.map { |r| Regexp.escape(r) }.join("|")

          status = shell_out_with_timeout(run_msys_command("pacman -Sl"))
          status.stdout.each_line do |line|
            case line
            when /^(#{package_repos}) #{Regexp.escape(@new_resource.package_name)} (.+)$/
              @candidate_version = $2.split(" ").first
            end
          end

          unless status.exitstatus == 0 || status.exitstatus == 1
            raise Chef::Exceptions::Package, "pacman failed - #{status.inspect}!"
          end

          unless @candidate_version
            raise Chef::Exceptions::Package, "pacman does not have a version of package #{@new_resource.package_name}"
          end

          @candidate_version
        end

        def install_package(name, version)
          shell_out_with_timeout!(run_msys_command("pacman --sync --noconfirm --noprogressbar#{expand_options(@new_resource.options)} #{name}"))
        end

        def upgrade_package(name, version)
          install_package(name, version)
        end

        def remove_package(name, version)
          shell_out_with_timeout!(run_msys_command("pacman --remove --noconfirm --noprogressbar#{expand_options(@new_resource.options)} #{name}"))
        end

        def purge_package(name, version)
          remove_package(name, version)
        end

        def run_msys_command(command)
          unless msystem_set?
            ENV['MSYSTEM'] = node['msys']['default_env']
          end

          return "#{node['msys']['install_dir']}/usr/bin/bash.exe -l -c #{command}"
        end

        def create_msys_path(path)
          path.gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR || '\\') if path
        end

        def msystem_set?
          return ENV['MSYSTEM'].is_set?
        end

        def msys_installed?
          return @is_installed if @is_installed
          @is_installed = ::File.exists?(::File.join(node['msys']['install_dir'], "msys2.exe"))
          return @is_installed
        end
      end
    end
  end
end
