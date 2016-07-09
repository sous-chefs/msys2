Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_execute

default_action :run

provides :msys2_execute, os: 'windows'
provides :execute, os: 'windows', override: true do |node|
  node['msys2']['override_execute']
end

property :command, String, name_attribute: true, required: true
property :returns, Fixnum, default: 0
property :environment, Hash, default: {}
property :cwd, String
property :live_stream, [true, false], default: false
property :sensitive, [true, false], default: false
property :msystem, [:mingw32, :mingw64, :msys], default: node['msys2']['default_env']

action :run do
  run_command(command, returns: returns, env: environment, cwd: cwd, live_stream: live_stream, sensitive: sensitive, msystem: msystem)
end
