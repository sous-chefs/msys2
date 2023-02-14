require 'rspec'
require_relative '../../../libraries/msys2_command_helper'

describe Msys2::CommandHelper do
  let(:helper) { Class.new.extend(Msys2::CommandHelper) }
  let(:install_dir) { 'C:/msys64' }

  describe '#generate_command' do
    let(:default_dir) { '/' }

    it 'default' do
      expect(helper.generate_command('ls -la', cwd: default_dir, install_dir: install_dir)).to eq(
        "#{install_dir}/usr/bin/bash.exe -l -c 'cd '#{default_dir}' && ls -la'"
      )
    end

    it 'cwd' do
      expect(helper.generate_command('ls -la', cwd: '~/', install_dir: install_dir)).to eq(
        "#{install_dir}/usr/bin/bash.exe -l -c 'cd '~/' && ls -la'"
      )
    end

    it 'install_dir' do
      expect(helper.generate_command('ls -la', cwd: default_dir, install_dir: 'C:/msys2')).to eq(
        "C:/msys2/usr/bin/bash.exe -l -c 'cd '#{default_dir}' && ls -la'"
      )
    end
  end

  describe '#generate_env' do
    let(:user) { ENV['username'] }
    let(:home) { "#{install_dir}/home/#{user}" }
    let(:msystem) { :msys }

    it 'default' do
      expect(helper.generate_env({}, msystem: msystem, install_dir: install_dir)).to include(
        HOME: home,
        CHERE_INVOKING: '1',
        MSYSTEM: msystem
      )
    end

    it 'home' do
      expect(helper.generate_env({}, msystem: msystem, install_dir: 'C:/msys2')).to include(
        HOME: "C:/msys2/home/#{user}",
        CHERE_INVOKING: '1',
        MSYSTEM: msystem
      )
    end

    it 'msystem' do
      expect(helper.generate_env({}, msystem: :mingw32, install_dir: install_dir)).to include(
        HOME: home,
        CHERE_INVOKING: '1',
        MSYSTEM: :mingw32
      )
    end
  end
end
