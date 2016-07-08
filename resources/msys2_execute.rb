Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_execute

property :command, String, name_property: true, required: true
property :environment, [:mingw64, :mingw32, :msys], default: :msys

default_action :run

#provides :execute, platform: :windows

action :run do
  case environment
  when :mingw64
    ENV['MSYSTEM'] = 'MINGW64'
  when :mingw32
    ENV['MSYSTEM'] = 'MINGW32'
  when :msys
    ENV['MSYSTEM'] = 'MSYS'
  end

  execute(generate_msys_command(command)) do
    live_stream node['msys']['verbose']
  end
end
