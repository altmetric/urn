# URN [![Build Status](https://travis-ci.org/altmetric/urn.svg?branch=master)](https://travis-ci.org/altmetric/urn)

Ruby library to validate and normalize URNs.

Note: This Gem doesn't strictly follow the [RFC2141](https://www.ietf.org/rfc/rfc2141.txt)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'urn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install urn

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

Copyright © 2015-2016 Altmetric LLP

Distributed under the [MIT License](http://opensource.org/licenses/MIT).
