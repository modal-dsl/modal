# Change Log

All notable changes to `mdAL` will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.1] - 2020-12-27

### Fixes

* AL CodeCop warnings for generated code (#19)
* AL code generator issues with short names for documents (#20)
* AL code generator issues with spaces in master entity's name (#22)

## [0.4.0] - 2020-12-16

### Added

* Improved modularity (#14, #16)
    - Now you can use `mdAL` in a more modularized way: You dont't have to specify all entities anymore but can choose to only generate AL code for parts of a solution (e. g. only Master or Supplemental entities).

### Changed

* Update to Xtext 2.23.0
* Update to picocli 4.5.2

## [0.3.1] - 2020-09-21

### Fixes

* Symbol references parsing issues (#15)

## [0.3.0] - 2020-08-31

### Added

* Generator for source code setup page extension
* Documentation
* Tests

### Changed

* Improved indentation of generated AL code

## [0.2.1] - 2020-07-23

### Fixes

* Content Assist issues

## [0.2.0] - 2020-07-17

### Added

* Generator for customizations needed to support Navigate on posted documents
* Snippets
* Documentation
* Document Line Events: `OnBeforeInitRecord` and `OnAfterInitRecord`
* Validation for Page Fields and Page Groups
* Support for Java JRE 8 and above

### Fixes

* Various bug fixes related to the generator and IDE module

## [0.1.0] - 2020-07-12

* Initial release
