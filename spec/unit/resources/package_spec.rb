# frozen_string_literal: true

require 'spec_helper'

describe 'msys2_package' do
  step_into :msys2_package
  platform 'windows', '2019'

  package_query = "C:/msys64/usr/bin/bash.exe -l -c 'cd '/' && pacman --query git'"

  context 'install action' do
    before do
      stub_command(package_query).and_return(false)
    end

    recipe do
      msys2_package 'git'
    end

    it do
      is_expected.to run_msys2_execute('installing package: git').with(
        command: %w(pacman --sync --needed --noconfirm --noprogressbar git),
        install_dir: 'C:/msys64',
        msystem: :msys
      )
    end
  end

  context 'remove action' do
    before do
      stub_command(package_query).and_return(true)
    end

    recipe do
      msys2_package 'git' do
        action :remove
      end
    end

    it do
      is_expected.to run_msys2_execute('removing package: git').with(
        command: %w(pacman --remove --noconfirm --noprogressbar git),
        install_dir: 'C:/msys64',
        msystem: :msys
      )
    end
  end
end
