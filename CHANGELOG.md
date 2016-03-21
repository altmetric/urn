# Change Log
All notable changes to this project will be documented in this file. This
project adheres to [Semantic Versioning](http://semver.org/).

## Current
### Changed
- Only return `URN` instances for valid `URN`s at creation. Raise `URN::InvalidURNError` otherwise.
- `#normalize` returns a normalized `URN` object instead of its `String` representation. You can get the normalized `String` representation with `.normalize.to_s`
- Do not allow hexadecimal numbers from 0 to 20. See [RFC2141](https://www.ietf.org/rfc/rfc2141.txt) section "2.4 Excluded characters".

### Added
- Shortcut method (`URN()`) at creation:
```ruby
urn = URN('URN:Name:Spec')
#=> #<URN:0x007fd97a835558 @urn="URN:Name:Spec">
```
- `REGEX` into the API documentation
- `#nid` returns the namespace identifier part.
```ruby
URN('URN:Name:Spec').nid
#=> "Name"
```
- `#nss` returns the namespace specific string part.
```ruby
URN('URN:Name:Spec').nss
#=> "Spec"
```
- `#to_s` returns the `String` representation.
```ruby
URN('URN:Name:Spec').to_s
#=> "URN:Name:Spec"
```
- `#===(other)` returns true if the URN objects are equivalent. This method normalizes both URNs before doing the comparison, and allows comparison against Strings.
- `#==(other)` returns true if the URN objects are equivalent. This method normalizes both URNs before doing the comparison.
- `#eql?(other)` returns true if the URN objects are equal. This method does NOT normalize either URN before doing the comparison.
- `.extract(str)` attempts to parse and merge a set of URNs. If no `block` is given, then returns the result as an `Array`. Else it calls `block` for each element in result and returns `nil`.
- URN initialization accepts a `URN` as argument:
```ruby
URN(URN('urn:foo:bar'))
#=> #<URN:0x007f85040434c8 @urn="urn:foo:bar">
```

### Removed
- `#valid?`. Validity check is now at object creation time, therefore all instances of `URN` are valid.


## [1.0.0] - 2016-03-09
### Changed
- The library is now [RFC2141](https://www.ietf.org/rfc/rfc2141.txt) compliant.

## [0.1.3] - 2016-03-07
### Fixed
- Explicitly require CGI standard library

## [0.1.2] - 2016-03-02
### Changed
- Extract the `URN` pattern to a separate variable, so that it's easier to use it in different Regex formats if needed.

## [0.1.1] - 2016-03-02
### Changed
- Stricter rules to validate a URN: it does not accept `urn` string as valid namespace identifier.

## [0.1.0] - 2016-03-01
### Added
- First version with basic implementation.

[1.0.0]: https://github.com/altmetric/urn/releases/tag/v1.0.0
[0.1.3]: https://github.com/altmetric/urn/releases/tag/v0.1.3
[0.1.2]: https://github.com/altmetric/urn/releases/tag/v0.1.2
[0.1.1]: https://github.com/altmetric/urn/releases/tag/v0.1.1
[0.1.0]: https://github.com/altmetric/urn/releases/tag/v0.1.0
