# msys2_execute

Runs a command through the MSYS2 Bash environment.

## Actions

| Action | Description |
| --- | --- |
| `:run` | Runs the command. Default action. |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `command` | String, Array | name property | Command and arguments to run. |
| `returns` | Integer | `0` | Expected exit code. |
| `environment` | Hash | `{}` | Extra environment variables. |
| `cwd` | String | `'/'` | Working directory inside MSYS2. |
| `live_stream` | true, false | `false` | Streams command output live. |
| `msystem` | Symbol | `:msys` | MSYS2 environment, one of `:msys`, `:mingw32`, or `:mingw64`. |
| `install_dir` | String | `'C:/msys64'` | MSYS2 install directory. |

## Examples

```ruby
msys2_execute 'pacman --version'
```

```ruby
msys2_execute 'make' do
  command %w[make check]
  cwd '/home/Administrator/project'
  msystem :mingw64
end
```
