# msys2_update

Updates all MSYS2 packages with `pacman`.

## Actions

| Action | Description |
| --- | --- |
| `:run` | Updates all packages. Default action. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `install_dir` | String | `'C:/msys64'` | MSYS2 install directory. |
| `msystem` | Symbol | `:msys` | MSYS2 environment, one of `:msys`, `:mingw32`, or `:mingw64`. |

## Examples

```ruby
msys2_update 'update MSYS2'
```

```ruby
msys2_update 'update MSYS2 in mingw64' do
  install_dir 'D:/msys64'
  msystem :mingw64
end
```
