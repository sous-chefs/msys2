module Msys2
  module Helper
    include Chef::Mixin::ShellOut
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

      # command.push(options)
      # TODO: Get rid of this string conversion when mixlib-shellout supports it for Windows: https://github.com/chef/mixlib-shellout/issues/125
      cmd = Mixlib::ShellOut.new(command.join(' '), options)

      if options.has_key?(:live_stream)
        cmd.live_stream = live_stream
      end

      cmd.run_command
      cmd
    end

    def override_package?
      node['msys2']['override_package']
    end

    def override_execute?
      node['msys2']['override_execute']
    end

    def msys2_installed?
      ::File.directory?("#{node['msys2']['install_dir']}")
    end

    def username
      ENV['username']
    end
  end
end
