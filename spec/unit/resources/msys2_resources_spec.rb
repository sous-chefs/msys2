require 'chefspec'

RSpec.configure do |config|
  config.color = true
  config.platform = 'windows'
  config.version = '10'
end

describe 'msys2 custom resources' do
  let(:chef_run) do
    allow(Dir).to receive(:exist?).with(anything).and_call_original
    allow(Dir).to receive(:exist?).with('C:/msys64').and_return(true)
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('username').and_return('runner')

    ChefSpec::SoloRunner.new(step_into: %w(msys2_update msys2_execute msys2_package)) do |node|
      node.override['msys2']['install_dir'] = 'C:/msys64'
      node.override['msys2']['default_env'] = :msys
      node.override['msys2']['packages'] = %w(git)
    end.converge('msys2::default')
  end
  let(:msys2_executes) do
    chef_run.resource_collection.select { |resource| resource.resource_name == :execute && resource.name == 'executing MSYS2 command' }
  end

  it 'runs the MSYS2 update through bash' do
    expect(msys2_executes.map(&:command)).to include(
      "C:/msys64/usr/bin/bash.exe -l -c 'cd '/' && pacman --sync --sysupgrade --refresh --noconfirm --noprogressbar'"
    )
  end

  it 'runs package installation through msys2_execute' do
    expect(chef_run).to run_msys2_execute('installing package: git').with(
      command: ['pacman', '--sync', '--needed', '--noconfirm', '--noprogressbar', 'git']
    )
  end

  it 'sets the MSYS2 command environment' do
    expect(msys2_executes).to all(have_attributes(environment: include(CHERE_INVOKING: '1', MSYSTEM: :msys)))
  end
end
