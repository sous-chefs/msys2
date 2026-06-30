# frozen_string_literal: true

# Public: Collection of MSYS2 operations
module Msys2
  # Public: Helper methods for MSYS2 commands
  module CommandHelper
    # Public: Converts a normal command into a command that runs through the MSYS2 bash.exe executable
    #
    # *args - The Array of the commands and arguments to run.
    # cwd   - The String of the directory the command should be run from.
    #         The default is / if not set
    def generate_command(*args, cwd: nil, install_dir: nil)
      command = [::File.join(install_dir, 'usr', 'bin', 'bash.exe'), '-l', '-c']
      command_args = args.flatten
      msys_command = if cwd.nil?
                       ['cd', "'/'", '&&'] + command_args
                     else
                       ['cd', "'#{cwd}'", '&&'] + command_args
                     end

      command.push("'#{msys_command.join(' ')}'")
      command.join(' ')
    end

    # Public: Appends the environmental variables in order to run the command through the MSYS2 bash.exe executable
    #
    # env     - The Hash of environmental variables that expect to be set.
    # msystem - The MSYS2 environment to run the command in.
    #           Options are: :mingw64, :mingw32, :msys
    def generate_env(env, msystem: nil, install_dir: nil)
      new_env = env.dup
      new_env[:HOME] = ::File.join(install_dir, 'home', ENV['USERNAME'] || ENV['username'] || ENV['USER'] || 'Administrator')
      new_env[:CHERE_INVOKING] = '1'
      new_env[:MSYSTEM] = msystem
      new_env
    end
  end
end
