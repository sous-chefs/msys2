module Msys2MonkeyPatch
  def shell_out(*args, **options)
    # Prepend all the pathing to the MSYS bash executable
    args = ["#{node['msys2']['install_dir']}/usr/bin/bash.exe", "-l", "-c"] + args

    # Make sure MSYSTEM is set
    unless options[:MSYSTEM].has_key?
      options[:MSYSTEM] = node['msys2']['default_env']
    end

    # Add in the necessary env vars
    options[:HOME] = "#{node['msys2']['install_dir']}/home/#{ENV['username']}"
    options[:CHERE_INVOKING] = "1"

    # Pass this along to the call
    super(args, options)
  end
end
