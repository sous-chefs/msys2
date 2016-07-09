Chef::Resource.send(:include, Msys2::Helper)

resource_name :msys2_update

default_action :run

action :run do
  log 'Beginning MSYS2 update'
  execute(generate_msys_command('pacman -Syu --noconfirm --needed')) do
    live_stream node['msys']['verbose']
  end
end
