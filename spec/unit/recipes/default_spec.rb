require 'chefspec'

describe 'msys2::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  #
  # Core
  #
  it 'installs MSYS2' do

  end

  it 'installed MSYS2 into a designated directory' do

  end

  it 'properly cleaned up the install' do

  end

  #
  # Package
  #
  it 'installed a package' do

  end

  it 'override_package installs a package with "package"' do

  end

  it 'removed a package' do

  end

  it 'override_package removed a package with "package"' do

  end

  it 'verbose echoed Pacman' do

  end

  #
  # Execute
  #
  it 'executes commands' do

  end

  it 'override_execute executes a command with "execute"' do

  end

  it 'checked the return value' do

  end

  it 'set enviromental variables' do

  end

  it 'changed the directory to run the command' do

  end

  it 'streamed output' do

  end

  it 'removed all output when silenced' do

  end

  it 'ran execute from different MSYS2 enviroments' do

  end

  #
  # Update
  #
  it 'ran the update command' do

  end

  it 'auto-update ran the update command' do

  end
end
