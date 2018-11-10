# Changelog

## [v1.0.0]
- Update dependencies to Ecto >= 3.0 and Postgrex >= 0.14

## [v1.0.0-rc.0]
- Update to work with Ecto 3.0-rc.0 and Postgrex 0.14-rc.1.
- Use `extra_applications` when defining application list.

## [v0.7.0] - 2017-11-16
- Update mix dependencies
- Fix tests from capitalization changes
- Fix compiler warnings ([van-mronov](https://github.com/van-mronov))

## [v0.6.0] - 2017-06-16
### Changed
- Add support for casting tuples ([bcardarella](https://github.com/bcardarella))


## [v0.5.0] - 2017-02-01
### Changed
- Improve ExDoc configuration for better HexDocs integration
- Better module documentation
- Pad MAC addresses with zeros ([darkbushido](https://github.com/darkbushido))


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

[Unreleased]: https://github.com/adam12/ecto_network/compare/v0.7.0...HEAD
[v0.7.0]: https://github.com/adam12/ecto_network/compare/v0.6.0...v0.7.0
[v0.6.0]: https://github.com/adam12/ecto_network/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/adam12/ecto_network/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/adam12/ecto_network/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/adam12/ecto_network/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/adam12/ecto_network/tree/v0.2.0
