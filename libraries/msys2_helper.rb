# Public: Collection of MSYS2 operations
module Msys2
  # Public: Helper methods for MSYS2 operations
  module Helper
    include Chef::Mixin::ShellOut

    # Public: Converts a normal command into a command that runs through the MSYS2 bash.exe executable
    #
    # *args - The Array of the commands and arguments to run.
    # cwd   - The String of the directory the command should be run from.
    #         The default is / if not set
    def generate_command(*args, cwd: nil)
      command = [::File.join(node['msys2']['install_dir'], 'usr', 'bin', 'bash.exe'), '-l', '-c']
      msys_command = if cwd.nil?
                       ['cd', '/', '&&'] + args
                     else
                       ['cd', cwd, '&&'] + args
                     end

      command.push("'#{msys_command.join(' ')}'")
      command.join(' ')
    end

    # Public: Appends the environmental variables in order to run the command through the MSYS2 bash.exe executable
    #
    # env     - The Hash of environmental variables that expect to be set.
    # msystem - The MSYS2 environment to run the command in.
    #           Options are: :mingw64, :mingw32, :msys
    def generate_env(env, msystem: nil)
      env[:HOME] = ::File.join(node['msys2']['install_dir'], 'home', ENV['username'])
      env[:CHERE_INVOKING] = '1'
      env[:MSYSTEM] = if msystem.nil?
                        node['msys2']['default_env']
                      else
                        msystem
                      end

      env
    end

    # Public: Determines if MSYS2 is installed on the system
    #
    # Returns Boolean
    def msys2_installed?
      ::Dir.exist?(node['msys2']['install_dir'])
    end

    # Public: Determines if MSYS2 should update when the msys2::default recipe
    # is run
    #
    # Returns Boolean
    def should_update?
      node['msys2']['auto-update']
    end
  end
end
