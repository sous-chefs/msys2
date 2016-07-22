Chef::Resource.send(:include, Msys2::CommandHelper)

resource_name :msys2_execute

default_action :run

provides :msys2_execute, os: 'windows'
provides :execute, os: 'windows', override: true do |node|
  node['msys2']['override_execute']
end

property :command, [String, Array], name_attribute: true, required: true
property :returns, Fixnum, default: 0
property :environment, Hash, default: {}
property :cwd, String, default: '/'
property :live_stream, [true, false], default: false
property :sensitive, [true, false], default: false
property :msystem, [:mingw32, :mingw64, :msys], default: node['msys2']['default_env']

action :run do
  msys_command = generate_command(command, cwd: cwd, install_dir: node['msys2']['install_dir'])
  msys_env = generate_env(environment, msystem: msystem, install_dir: node['msys2']['install_dir'])

  previous_value = node['msys2']['override_execute']
  node.override['msys2']['override_execute'] = false

  execute 'executing MSYS2 command' do
    command msys_command
    environment msys_env
    returns new_resource.returns
    live_stream new_resource.live_stream
    sensitive new_resource.sensitive
  end

  node.override['msys2']['override_execute'] = previous_value
end
