# MSYS2 Limitations

MSYS2 is a Windows software distribution and build environment. This cookbook supports Windows only.

## Vendor Platform Support

MSYS2's current Windows support policy says:

* The GUI installer requires 64-bit Windows 10 1809 or newer, or Windows Server 2019 or newer.
* MSYS/Cygwin packages require 64-bit Windows 10 or Windows Server 2016 or newer.
* MinGW packages require 64-bit Windows 10 or Windows Server 2016 or newer, though upstream software may impose stricter requirements.
* Windows 32-bit support is no longer active.
* ARM64 support is preliminary and requires Windows 11 ARM64 for the MSYS2 ARM64 environment.

## Installer And Package Constraints

The cookbook installs MSYS2 from the current upstream installer URL by default:

* `https://repo.msys2.org/distrib/x86_64/msys2-x86_64-latest.exe`

The installer creates the base MSYS2 environment. Ongoing package management is handled by `pacman`
through the `msys2_package`, `msys2_execute`, and `msys2_update` resources.

## Test Strategy

MSYS2 cannot be validated in Linux containers. Kitchen uses Windows platforms, and CI should run
the default suite on `windows-latest`.
