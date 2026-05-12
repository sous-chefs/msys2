# frozen_string_literal: true

require 'spec_helper'

describe 'msys2_execute' do
  step_into :msys2_execute
  platform 'windows', '2019'

  context 'with default properties' do
    recipe do
      msys2_execute 'pacman --version'
    end

    it do
      is_expected.to run_execute('executing MSYS2 command').with(
        command: "C:/msys64/usr/bin/bash.exe -l -c 'cd '/' && pacman --version'",
        environment: {
          HOME: "C:/msys64/home/#{ENV['USERNAME'] || ENV['USER'] || 'Administrator'}",
          CHERE_INVOKING: '1',
          MSYSTEM: :msys,
        },
        returns: 0,
        live_stream: false
      )
    end
  end

  context 'with custom properties' do
    recipe do
      msys2_execute 'install git' do
        command %w(pacman --sync git)
        cwd '/tmp'
        environment PATH: '/usr/bin'
        install_dir 'D:/msys64'
        msystem :mingw64
        returns 2
        live_stream true
      end
    end

    it do
      is_expected.to run_execute('executing MSYS2 command').with(
        command: "D:/msys64/usr/bin/bash.exe -l -c 'cd '/tmp' && pacman --sync git'",
        environment: {
          PATH: '/usr/bin',
          HOME: "D:/msys64/home/#{ENV['USERNAME'] || ENV['USER'] || 'Administrator'}",
          CHERE_INVOKING: '1',
          MSYSTEM: :mingw64,
        },
        returns: 2,
        live_stream: true
      )
    end
  end
end
