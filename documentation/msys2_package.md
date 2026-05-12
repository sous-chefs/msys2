# msys2_package

Installs or removes MSYS2 packages with `pacman`.

## Actions

| Action | Description |
| --- | --- |
| `:install` | Installs a package. Default action. |
| `:remove` | Removes a package. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `package` | String | name property | MSYS2 package name. |
| `install_dir` | String | `'C:/msys64'` | MSYS2 install directory. |
| `msystem` | Symbol | `:msys` | MSYS2 environment, one of `:msys`, `:mingw32`, or `:mingw64`. |

## Examples

```ruby
msys2_package 'git'
```

```ruby
msys2_package 'mingw-w64-x86_64-gcc' do
  msystem :mingw64
end
```

```ruby
msys2_package 'git' do
  action :remove
end
```
