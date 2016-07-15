require 'chefspec'

RSpec.configure do |config|
  config.color = true
  config.platform = 'windows'
  config.version = '10'
end

context "msys2::default" do
  context 'MSYS2 not installed' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['msys2']['packages'] = ['git', 'tig']
      end.converge(described_recipe)
    end

    it 'runs installer' do
      allow(Dir).to receive(:exists?).with(anything).and_call_original
      allow(Dir).to receive(:exists?).with('C:/msys64').and_return(false)

      expect(chef_run).to msys2_installer('install MSYS2')
    end

    it 'runs updater' do
      expect(chef_run).to msys2_update('update MSYS2')
    end

    it 'installs packages from node' do
      expect(chef_run).to install_msys2_package('git')
      expect(chef_run).to install_msys2_package('tig')
    end
  end

  context 'MSYS2 installed' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['msys2']['packages'] = ['git', 'tig']
      end.converge(described_recipe)
    end

    it 'does not run installer' do
      allow(Dir).to receive(:exists?).with(anything).and_call_original
      allow(Dir).to receive(:exists?).with('C:/msys64').and_return(true)

      expect(chef_run).to_not msys2_installer('install MSYS2')
    end

    it 'runs updater' do
      expect(chef_run).to msys2_update('update MSYS2')
    end
  end
end
