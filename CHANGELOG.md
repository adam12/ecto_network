# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## unreleased

- Remove redundant case from typechecker warning ([hchienjo](https://github.com/hchienjo))
- Validate IP address when casting tuple ([zaratedev](https://github.com/zaratedev))
- No longer testing for Ecto 3.0 ([adam12](https://github.com/adam12))
- Minimum version for Elixir now 1.9 ([adam12](https://github.com/adam12))

## v1.5.0 - 2024-02-09

- Misc deprecation cleanups ([adam12](https://github.com/adam12))
- Parse addresses in strict mode ([aerosol](https://github.com/aerosol))


## v1.4.0 - 2023-12-12

- Misc doc changes ([kianmeng](https://github.com/kianmeng))
- Add excoveralls for test coverage reporting ([sbothma](https://github.com/sbothma))
- Add @type annotations ([s3cur3](https://github.com/s3cur3))


## v1.3.0 - 2020-01-04

- Parsing of invalid MAC Addresses will no longer raise ArgumentError #19 ([sneako](https://github.com/sneako))
- Parsing of INET addresses without a netmask no longer raise ArgumentError (#20) ([mikl](https://github.com/mikl))


## v1.2.0 - 2019-11-01

- Ecto 3.2 support ([halostatue](https://github.com/halostatue))
- Test database configurable through `DATABASE_URL` environment variable


## v1.1.0 - 2019-04-12

- POSSIBLY BREAKING CHANGE: Ensure inet records returned from database have a default
  netmask instead of nil (#13)


## v1.0.0 - 2018-11-10

- Update dependencies to Ecto >= 3.0 and Postgrex >= 0.14


## v1.0.0-rc.0 - 2018-10-19

- Update to work with Ecto 3.0-rc.0 and Postgrex 0.14-rc.1.
- Use `extra_applications` when defining application list.


## v0.7.0 - 2017-11-16

- Update mix dependencies
- Fix tests from capitalization changes
- Fix compiler warnings ([van-mronov](https://github.com/van-mronov))


## v0.6.0 - 2017-06-16

### Changed
- Add support for casting tuples ([bcardarella](https://github.com/bcardarella))


## v0.5.0 - 2017-02-01

### Changed
- Improve ExDoc configuration for better HexDocs integration
- Better module documentation
- Pad MAC addresses with zeros ([darkbushido](https://github.com/darkbushido))


## v0.4.0 - 2016-09-17

### Changed
- Moved parsing and decoding to `cast` functions. If you were using inserts
  directly without casting (ie. inside a changeset), functionality may be broken.

- Switch to :inet for parsing network portion of CIDR. IPv6 should be supported for
  both types now.


## v0.3.0 - 2016-09-04

### Added
- IPv6 Support ([@webzepter](https://github.com/webzepter))


## v0.2.0 - 2016-06-29

### Added
- Initial functionality implemented
