# AGENTS.md

## Cookbook Purpose

This cookbook manages MSYS2 on Windows through custom resources for installing the base
distribution, running commands inside the MSYS2 environment, updating packages with `pacman`, and
installing/removing MSYS2 packages.

## Agent Findings

* This is a Windows-only cookbook. Do not add Linux/Dokken Kitchen coverage; MSYS2 must be tested
  with the exec driver on Windows runners.
* Full migration removes the public `msys2::default` recipe and `node['msys2']` attributes. Use the
  resource API documented in `documentation/` and the breaking-change guide in `migration.md`.
* Dependency resolution is Policyfile-based. Do not reintroduce Berkshelf unless maintainers make a
  deliberate compatibility decision.
* Keep package operations idempotent by querying `pacman` before install/remove. Do not use removed
  node attributes such as `node['msys2']['install_dir']`; use resource properties.

## Package Availability

MSYS2 packages are managed by upstream `pacman` repositories after the base installer creates the
MSYS2 environment. The cookbook does not configure APT, DNF/YUM, or Zypper repositories.

## Architecture Limitations

* The default installer URL uses the upstream 64-bit x86_64 installer.
* Windows 32-bit support is no longer active upstream.
* ARM64 support is preliminary upstream and requires Windows 11 ARM64 for the MSYS2 ARM64
  environment. This cookbook currently defaults to x86_64.

## Source/Compiled Installation

This cookbook does not build MSYS2 from source. It installs the upstream Windows installer and then
uses `pacman` for package management.

## Known Issues

* The upstream installer and package repositories are network-dependent, so integration tests can
  fail on transient MSYS2 mirror or GitHub runner networking issues.
* The `msys2_update` resource can change many packages. Test recipes should guard update behavior
  when validating idempotency.

## Test and CI Notes

* Use `KITCHEN_LOCAL_YAML=kitchen.exec.yml` with the `windows-latest` platform.
* The default Kitchen suite must run `recipe[test::default]` and verify `test/integration/default`.
* Local non-Windows hosts can run Cookstyle, ChefSpec, and static Ruby checks, but the authoritative
  converge evidence comes from Windows Kitchen on GitHub Actions.
