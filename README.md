# URN [![Build Status](https://travis-ci.org/altmetric/urn.svg?branch=master)](https://travis-ci.org/altmetric/urn)

Ruby library to validate and normalize URNs according to [RFC 2141](https://www.ietf.org/rfc/rfc2141.txt).

[![Gem Version](https://badge.fury.io/rb/urn.svg)](https://badge.fury.io/rb/urn)  

**Supported Ruby versions:** 1.8.7, 1.9.2, 1.9.3, 2.0, 2.1, 2.2, 2.3

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'urn', '~> 1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install urn -v '~> 1.0'

## Usage

```ruby
urn = URN('URN:NameSpace:Identifier')
#=> #<URN:0x007fd97a835558 @urn="URN:NameSpace:Identifier">

urn = URN.new('URN:NameSpace:Identifier')
#=> #<URN:0x007fd97a835558 @urn="URN:NameSpace:Identifier">

urn.normalize
#=> "urn:namespace:Identifier"

urn = URN('123')
#=> URN::InvalidURNError: bad URN(is not URN?): 123
```

## API Documentation

### `URN::PATTERN`

```ruby
text.match(/\?urn=(#{URN::PATTERN})/)
```

Return a `String` of an unanchored regular expression suitable for matching
URNs.

### `URN::REGEX`

```ruby
URN::REGEX
#=> /\A(?i:urn:(?!urn:)[a-z0-9][a-z0-9-]{1,31}:(?:[a-z0-9()+,-.:=@;$_!*']|%[0-9a-f]{2})+)\z/
```

Return an `Regexp` object with the anchored regular expression suitable to match a URN.

### `URN()` or `URN.new`

```ruby
urn = URN('urn:nid:nss')
#=> #<URN:0xdecafbad @urn="urn:nid:nss">

urn = URN.new('urn:nid:nss')
#=> #<URN:0xdecafbad @urn="urn:nid:nss">

urn = URN.new('1234')
#=> URN::InvalidURNError: bad URN(is not URN?): 1234
```

Return a new `URN` instance when the given string is valid according to [RFC 2141](https://www.ietf.org/rfc/rfc2141.txt). Otherwise, it raises an `URN::InvalidURNError`

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
