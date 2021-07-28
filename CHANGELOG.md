# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Add Dart [#36](https://github.com/cucumber/build/pull/36)

### Changed
- Bump Node version from 12.22.1 to 14.17.3 [#37](https://github.com/cucumber/build/pull/37)

## [0.5.2]
### Changed
- Bump Node version from 12.16.2 to 12.22.1 [#33](https://github.com/cucumber/build/pull/33)

## [0.5.1]
### Fixed
- Add symlink for `chromium-browser` [#31](https://github.com/cucumber/cucumber-build/pull/31)

## [0.5.0]
### Removed
- Remove Mono [#28](https://github.com/cucumber/cucumber-build/pull/28)

## [0.4.4]
### Added
- Provide a multi-arch image (amd64 and arm64) to allow for Apple M1 silicon [#11](https://github.com/cucumber/cucumber-build/issues/11)

### Changed
- Check hash of all dependencies installed via curl/wget [#14](https://github.com/cucumber/cucumber-build/issues/14)

## [0.3.0]
### Changed
- Change Dockerfile to install .NET 5 SDK - [#19](https://github.com/cucumber/cucumber-build/pull/19)
- Switched to use Docker buildx

## [0.2.0] - 2021-05-03
### Added
- Experimental arm64 build

## [0.1.0] - 2021-07-21
### Added
- Initial version

[Unreleased]: https://github.com/cucumber/build/compare/v0.6.0...HEAD
[0.6.0]: https://github.com/cucumber/build/compare/v0.5.2...0.6.0
[0.5.2]: https://github.com/cucumber/build/compare/0.5.1...0.5.2
[0.5.1]: https://github.com/cucumber/build/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/cucumber/build/compare/0.4.4...0.5.0
[0.4.4]: https://github.com/cucumber/build/compare/0.3.0...0.4.4
[0.3.0]: https://github.com/cucumber/build/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/cucumber/build/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/cucumber/build/compare/8680f...0.1.0
