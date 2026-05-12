# msys2_installer

Installs or removes MSYS2 on Windows.

## Actions

| Action | Description |
| --- | --- |
| `:install` | Installs MSYS2. Default action. |
| `:run` | Backward-compatible install action. |
| `:remove` | Runs the MSYS2 uninstaller and deletes the install directory. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `install_dir` | String | `'C:/msys64'` | Directory where MSYS2 is installed. |
| `installer_url` | String | `'https://repo.msys2.org/distrib/x86_64/msys2-x86_64-latest.exe'` | Installer URL. |
| `installer_checksum` | String | `nil` | Optional SHA256 checksum for the installer. |

## Examples

```ruby
msys2_installer 'install MSYS2'
```

```ruby
msys2_installer 'install MSYS2 to D' do
  install_dir 'D:/msys64'
end
```

```ruby
msys2_installer 'remove MSYS2' do
  install_dir 'C:/msys64'
  action :remove
end
```
