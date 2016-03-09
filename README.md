# URN [![Build Status](https://travis-ci.org/altmetric/urn.svg?branch=master)](https://travis-ci.org/altmetric/urn)

Ruby library to validate and normalize URNs.

**Current version:** 0.1.3
**Supported Ruby versions:** 1.8.7, 1.9.2, 1.9.3, 2.0, 2.1, 2.2, 2.3

Note: This gem doesn't strictly follow [RFC 2141](https://www.ietf.org/rfc/rfc2141.txt)

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'urn', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install urn -v '~> 0.1'

## Usage

```ruby
urn = URN.new('URN:NameSpace:Identifier')
#=> #<URN:0x007fd97a835558 @urn="URN:NameSpace:Identifier">

urn.valid?
#=> true

urn.normalize
#=> "urn:namespace:Identifier"
```

## API Documentation

### `URN::PATTERN`

```ruby
text.match(/\?urn=(#{URN::PATTERN})/)
```

Return a `String` of an unanchored regular expression suitable for matching
URNs.

### `URN.new`

```ruby
urn = URN.new('urn:nid:nss')
#=> #<URN:0xdecafbad @urn="urn:nid:nss">
```

Return a new `URN` instance with the given string.

### `URN#valid?`

```ruby
URN.new('foo').valid?
#=> false

URN.new('urn:foo:bar').valid?
#=> true
```

Returns true if the `URN` is valid according to the following rules:

* Begins with `urn:` (case-insensitive);
* Contains a namespace identifier consisting solely of letters, numbers or
  hyphens and is not the string `urn`;
* Contains a namespace specific string consisting of any non-whitespace
  character.

### `URN#normalize`

```ruby
URN.new('URN:FOO:BAR').normalize
#=> "urn:foo:BAR"
```

Return a normalized `String` representation of the `URN`, normalizing the case
of the `urn` token and namespace identifier.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/altmetric/urn.

## License

Copyright © 2016 Altmetric LLP

Distributed under the [MIT License](http://opensource.org/licenses/MIT).
