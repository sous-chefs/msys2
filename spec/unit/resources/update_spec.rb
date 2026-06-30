# frozen_string_literal: true

require 'spec_helper'

describe 'msys2_update' do
  step_into :msys2_update
  platform 'windows', '2019'

  recipe do
    msys2_update 'default' do
      install_dir 'D:/msys64'
      msystem :mingw64
    end
  end

  it do
    is_expected.to run_msys2_execute('update MSYS2').with(
      command: %w(pacman --sync --sysupgrade --refresh --noconfirm --noprogressbar),
      install_dir: 'D:/msys64',
      msystem: :mingw64
    )
  end
end
