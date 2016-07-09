module Msys2
  module Helper
    include Chef::Mixin::ShellOut
    # Public: Runs a command within the MSYS2 environment.  Is run through the Mixlib::ShellOut handler
    #
    # *args       - The Array of the commands and arguments to be run
    # returns     - The Fixnum value that's expected to be returned from the command
    # env         - The Hash of environmental variables that expect to be set.  MSYS2 defaults are set.
    # cwd         - The String of the directory the command should be run from.  Prepends a 'cd' command.
    # live_stream - The Boolean choice to stream the output to the console
    # sensitive   - The Boolean choice to prevent all output from reaching the console
    # msystem     - The MSYS2 environment to run the command in (mingw64/mingw32/msys)
    #
    # Returns the result from the Mixlib::ShellOut object
    def run_command(*args, returns: 0, env: {}, cwd: nil, live_stream: false, sensitive: false, msystem: nil)
      # Prepend in the calls to bash
      command = [::File.join("#{node['msys2']['install_dir']}", 'usr', 'bin', 'bash.exe'), '-l', '-c']
      msys_command = []

      options = {}

      # Handle returns
      options[:returns] = returns if returns

      # Handle env for MSYS2
      msys_env = {
        'HOME' => ::File.join("#{node['msys2']['install_dir']}", 'home', username),
        'CHERE_INVOKING' => '1'
      }

      # Handle msystem
      unless msystem.nil?
        msys_env[:MSYSTEM] = msystem
      else
        msys_env[:MSYSTEM] = node['msys2']['default_env']
      end

      # Add in any env that is passed to the command
      msys_env.merge(env)

      options[:environment] = msys_env

      # Handle cwd
      unless cwd.nil?
        # Prepend a cd 'path' && to the command passed into bash
        msys_command = ['cd', "#{cwd}", "&&"]
      end

      # Handle live_stream and sensitive
      if (Chef::Log.info? || live_stream || node['msys2']['verbose']) && !sensitive
        options[:live_stream] = STDOUT
      end

      # Build the MSYS2 command string as a hard string that's quoted
      msys_command = msys_command + args

      # Finish up the command array
      command.push("'" + msys_command.join(' ') + "'")

      Chef::Log.debug("Running command: #{command.join(' ')} -> #{options}")

      # command.push(options)
      # TODO: Get rid of this string conversion when mixlib-shellout supports it for Windows: https://github.com/chef/mixlib-shellout/issues/125
      cmd = Mixlib::ShellOut.new(command.join(' '), options)

      if options.has_key?(:live_stream)
        cmd.live_stream = options[:live_stream]
      end

      cmd.run_command
      cmd
    end

    # Public: Determines if MSYS2 is installed on the system
    #
    # Returns Boolean
    def msys2_installed?
      ::File.directory?("#{node['msys2']['install_dir']}")
    end

    # Public: Determines if MSYS2 should update when the msys2::default recipe is run
    #
    # Returns Boolean
    def should_update?
      node['msys2']['auto-update']
    end
  end
end
