# frozen_string_literal: true

title 'MSYS2 Default Tests'

control 'msys2-install-01' do
  impact 1.0
  title 'MSYS2 is installed'

  describe file('C:/msys64/usr/bin/bash.exe') do
    it { should exist }
  end
end

control 'msys2-package-01' do
  impact 1.0
  title 'Git is installed through pacman'

  describe command('C:/msys64/usr/bin/bash.exe -l -c "pacman -Q git"') do
    its('exit_status') { should eq 0 }
  end
end
