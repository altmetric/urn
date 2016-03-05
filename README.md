# URN [![Build Status](https://travis-ci.org/altmetric/urn.svg?branch=master)](https://travis-ci.org/altmetric/urn)

Ruby library to validate and normalize URNs.

**Current version:** 0.1.2  
**Supported Ruby versions:** 2.1, 2.2, 2.3

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/altmetric/urn.

## License

Copyright © 2016 Altmetric LLP

Distributed under the [MIT License](http://opensource.org/licenses/MIT).
