# frozen_string_literal: true

unified_mode true

provides :msys2_execute, os: 'windows'

property :command, [String, Array], name_property: true
property :returns, Integer, default: 0
property :environment, Hash, default: {}
property :cwd, String, default: '/'
property :live_stream, [true, false], default: false
property :msystem, [:mingw32, :mingw64, :msys], default: :msys
property :install_dir, String, default: 'C:/msys64'

action :run do
  msys_command = generate_command(new_resource.command, cwd: new_resource.cwd, install_dir: new_resource.install_dir)
  msys_env = generate_env(new_resource.environment, msystem: new_resource.msystem, install_dir: new_resource.install_dir)

  execute 'executing MSYS2 command' do
    command msys_command
    environment msys_env
    returns new_resource.returns
    live_stream new_resource.live_stream
    sensitive new_resource.sensitive
  end
end

action_class do
  include Msys2::CommandHelper
end
