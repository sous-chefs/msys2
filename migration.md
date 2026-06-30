# Migration

This cookbook now exposes MSYS2 management through custom resources only.

## Removed APIs

The following legacy APIs were removed:

* `recipe[msys2::default]`
* `node['msys2']['install_dir']`
* `node['msys2']['auto_update']`
* `node['msys2']['packages']`
* `node['msys2']['default_env']`
* `node['msys2']['verbose']`
* `node['msys2']['override_package']`
* `node['msys2']['override_execute']`

The cookbook no longer globally overrides built-in `package` or `execute` resources on Windows.
Use `msys2_package` and `msys2_execute` explicitly.

## Replacement

Replace the old recipe and attributes with direct resource declarations:

```ruby
msys2_installer 'install MSYS2' do
  install_dir 'C:/msys64'
end

msys2_update 'update MSYS2' do
  install_dir 'C:/msys64'
end

%w(git tig).each do |pkg|
  msys2_package pkg do
    install_dir 'C:/msys64'
  end
end
```

The integration test cookbook shows the supported pattern in `test/cookbooks/test/recipes/default.rb`.
