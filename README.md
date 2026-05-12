# MSYS2 Cookbook

This cookbook provides custom resources to install [MSYS2](https://www.msys2.org/) and interact with the MSYS2 environment.

This was built as an alternative for [mingw](https://github.com/chef-cookbooks/mingw) that focuses moreso on the MSYS2 environment and allows you to utilize MSYS2 like a small UNIX environment within your Windows node.

## Platform

* Windows

## Migration

The `msys2::default` recipe and `node['msys2']` attributes have been removed. See [migration.md](migration.md) for the resource-based replacement.

## Resources

* [msys2_installer](documentation/msys2_installer.md)
* [msys2_execute](documentation/msys2_execute.md)
* [msys2_package](documentation/msys2_package.md)
* [msys2_update](documentation/msys2_update.md)
