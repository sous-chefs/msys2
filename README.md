# MSYS2 Cookbook

This cookbook will install [MSYS2](https://msys2.github.io/) and has LWRPs to interact with the MSYS2 environment.

This was built as an alternative for [mingw](https://github.com/chef-cookbooks/mingw) that focuses moreso on the MSYS2 environment and allows you to utilize MSYS2 like a small UNIX environment within your Windows node.

## Platform

- Windows

# Recipes

- default: Will install MSYS2, optionally update all of the packages, and optionally install packages set in the attributes.

# LWRPs
**Bolded** actions are the default actions.

- `msys2_installer`: Installs MSYS2.
  - **`:run`**: Installs MSYS2.
  - Configured with `node['msys2']['install_dir']`.
- `msys2_package`: Installs a package in MSYS2.
  - **`:install`**: Installs a package.
  - `:remove`: Removes a package.
- `msys2_execute`: Executes a command within the MSYS2 environment.
  - **`:run`**: Runs a command.
    - `cwd`: Runs the command from a different directory.  Default directory is `/`.
    - `returns`: Checks the return value for success.  Default successful return value is `0`.
    - `environment`: A hash that contains environmental variables that should be set before execution.
    - `live_stream`: Outputs the command in execution as it runs.
    - `sensitive`: Prevents all output from being written out due to sensitive information.
    - `msystem`: Sets the MSYS2 environment to run the command from.  Available values are `:msys :mingw32 :mingw64`.
- `msys2_update`: Updates all packages in MSYS2.
  - **`:run`**: Updates all packages in MSYS2.

# Attributes

- `node['msys2']['install_dir']`: The directory to install MSYS2 to.
- `node['msys2']['auto_update']`: Will automatically update all packages when `msys2::default` is run.
- `node['msys2']['packages']`: Packages to assure are installed when `msys2::default` is run.
- `node['msys2']['default_env']`: The default MSYS2 environment to run commands in.  Options include: `:msys :mingw32 :mingw64`.
- `node['msys2']['verbose']`: Makes all commands run verbose.
- `node['msys2']['override_package']`: Makes MSYS2 handle all `package` resources run on the Windows node.
- `node['msys2']['override_execute']`: Makes MSYS2 handle all `execute` resources run on the Windows node.
