# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.2.2] - 2018-07-02
Maintenance release
### Added
- PDK Update

### Fixed
- Package resource dependency (should be on apt\_update not apt::source)

## [0.2.1] - 2017-11-07
Maintenance release
### Added
- PDK compatibility
- Manifest unit tests

### Fixed
- Ruby style violations (rubocop)

## [0.2.0] - 2017-10-12
### Added
- New parameters to `flatpak` type: `name`, `arch`, `branch`

### Changed
- `flatpak` type's namevar is now `name` instead of `ref`. Behavior and
  expected values remains the same as before.
- The `remote` parameter on the `flatpak` type is now explicitly required
  when installing a package.

### Fixed
- Made repo source file match PPA naming scheme
- Support for older Facter versions (<3.0.0)
- `flatpak` type now accepts a full Identifier Triple for `ref` parameter

## [0.1.1] - 2017-09-12
### Added
- Changelog

### Fixed
- License format in Module metadata.json
- Unbounded dependency version ranges

## [0.1.0] - 2017-09-11
Initial release
### Added
- support for Ubuntu (possibly other Debian-based distributions using apt)
- Install Flatpak from developer PPA
- Add/Remove Flatpak remotes
- Install/uninstall Flatpak apps

[0.2.2]: https://github.com/brwyatt/puppet-flatpak/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/brwyatt/puppet-flatpak/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/brwyatt/puppet-flatpak/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/brwyatt/puppet-flatpak/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/brwyatt/puppet-flatpak/compare/ff5cbee...v0.1.0
