# frozen_string_literal: true

unified_mode true

provides :msys2_installer, os: 'windows'
default_action :install

use '_partial/_install'

property :installer_url, String, default: 'https://repo.msys2.org/distrib/msys2-x86_64-latest.exe'
property :installer_checksum, String

action :install do
  installer_path = ::File.join(Chef::Config[:file_cache_path], 'msys2-installer.exe')
  control_script_path = ::File.join(Chef::Config[:file_cache_path], 'msys2-install.js')

  remote_file installer_path do
    source new_resource.installer_url
    checksum new_resource.installer_checksum if new_resource.installer_checksum
    action :create
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  file control_script_path do
    content <<~JS
      function Controller() { }

      Controller.prototype.IntroductionPageCallback = function() {
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.TargetDirectoryPageCallback = function() {
          var page = gui.pageWidgetByObjectName("TargetDirectoryPage");
          page.TargetDirectoryLineEdit.setText(installer.value("dir"));
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.StartMenuDirectoryPageCallback = function() {
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.FinishedPageCallback = function() {
          var page = gui.pageWidgetByObjectName("FinishedPage");
          page.RunItCheckBox.checked = false;
          gui.clickButton(buttons.FinishButton);
      }
    JS
    action :create
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  execute 'install msys' do
    command "\"#{installer_path}\" --platform minimal --script \"#{control_script_path}\" dir=#{new_resource.install_dir}"
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  file installer_path do
    action :delete
    only_if { msys2_installed?(new_resource.install_dir) }
  end

  file control_script_path do
    action :delete
    only_if { msys2_installed?(new_resource.install_dir) }
  end
end

action :run do
  installer_path = ::File.join(Chef::Config[:file_cache_path], 'msys2-installer.exe')
  control_script_path = ::File.join(Chef::Config[:file_cache_path], 'msys2-install.js')

  remote_file installer_path do
    source new_resource.installer_url
    checksum new_resource.installer_checksum if new_resource.installer_checksum
    action :create
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  file control_script_path do
    content <<~JS
      function Controller() { }

      Controller.prototype.IntroductionPageCallback = function() {
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.TargetDirectoryPageCallback = function() {
          var page = gui.pageWidgetByObjectName("TargetDirectoryPage");
          page.TargetDirectoryLineEdit.setText(installer.value("dir"));
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.StartMenuDirectoryPageCallback = function() {
          gui.clickButton(buttons.NextButton);
      }

      Controller.prototype.FinishedPageCallback = function() {
          var page = gui.pageWidgetByObjectName("FinishedPage");
          page.RunItCheckBox.checked = false;
          gui.clickButton(buttons.FinishButton);
      }
    JS
    action :create
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  execute 'install msys' do
    command "\"#{installer_path}\" --platform minimal --script \"#{control_script_path}\" dir=#{new_resource.install_dir}"
    not_if { msys2_installed?(new_resource.install_dir) }
  end

  file installer_path do
    action :delete
    only_if { msys2_installed?(new_resource.install_dir) }
  end

  file control_script_path do
    action :delete
    only_if { msys2_installed?(new_resource.install_dir) }
  end
end

action :remove do
  execute 'uninstall msys' do
    command "\"#{::File.join(new_resource.install_dir, 'uninstall.exe')}\" pr --confirm-command"
    only_if { ::File.exist?(::File.join(new_resource.install_dir, 'uninstall.exe')) }
  end

  directory new_resource.install_dir do
    recursive true
    action :delete
    only_if { ::Dir.exist?(new_resource.install_dir) }
  end
end

action_class do
  include Msys2::Helper
end
