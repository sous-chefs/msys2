require 'spec_helper'

describe 'MSYS2 installation' do
  describe file('C:/msys64/') do
    it { should be_directory }
  end

  describe file('C:/msys64/usr/bin/bash.exe') do
    it { should exist }
  end

  describe command('C:/msys64/usr/bin/bash.exe -l -c "git --version"') do
    its(:stdout) { should match(/git version [0-9.]+/) }
  end
end
