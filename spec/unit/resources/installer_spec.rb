# frozen_string_literal: true

require 'spec_helper'

describe 'msys2_installer' do
  step_into :msys2_installer
  platform 'windows', '2019'

  before do
    allow(Dir).to receive(:exist?).and_call_original
    allow(Dir).to receive(:exist?).with('C:/msys64').and_return(false)
    allow(File).to receive(:exist?).and_call_original
  end

  context 'install action' do
    recipe do
      msys2_installer 'default'
    end

    it do
      is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/msys2-installer.exe").with(
        source: 'https://repo.msys2.org/distrib/msys2-x86_64-latest.exe'
      )
    end
    it { is_expected.to create_file("#{Chef::Config[:file_cache_path]}/msys2-install.js") }

    it do
      is_expected.to run_execute('install msys').with(
        command: "\"#{Chef::Config[:file_cache_path]}/msys2-installer.exe\" --platform minimal --script \"#{Chef::Config[:file_cache_path]}/msys2-install.js\" dir=C:/msys64"
      )
    end
  end

  context 'remove action' do
    before do
      allow(File).to receive(:exist?).with('C:/msys64/uninstall.exe').and_return(true)
      allow(Dir).to receive(:exist?).with('C:/msys64').and_return(true)
    end

    recipe do
      msys2_installer 'default' do
        action :remove
      end
    end

    it do
      is_expected.to run_execute('uninstall msys').with(
        command: '"C:/msys64/uninstall.exe" pr --confirm-command'
      )
    end

    it { is_expected.to delete_directory('C:/msys64').with(recursive: true) }
  end
end
