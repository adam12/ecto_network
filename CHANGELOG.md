# Changelog

## [Unreleased]
- Nothing yet


## [v0.4.0] - 2016-09-17
### Changed
- Moved parsing and decoding to `cast` functions. If you were using inserts
  directly without casting (ie. inside a changeset), functionality may be broken.

- Switch to :inet for parsing network portion of CIDR. IPv6 should be supported for
  both types now.


## [v0.3.0] - 2016-09-04
### Added
- IPv6 Support ([@webzepter](https://github.com/webzepter))


## [v0.2.0] - 2016-06-29
### Added
- Initial functionality implemented

[Unreleased]: https://github.com/adam12/ecto_network/compare/v0.4.0...HEAD
[v0.4.0]: https://github.com/adam12/ecto_network/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/adam12/ecto_network/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/adam12/ecto_network/tree/v0.2.0
