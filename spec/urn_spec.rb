# encoding: utf-8
require 'urn'

RSpec.describe URN do
  describe 'URN' do
    it 'returns a URN if it is valid' do
      expect(URN('urn:namespace:specificstring')).to be_kind_of(described_class)
    end

    it 'raise InvalidURNError if it is not valid' do
      expect { URN('urn:urn:1234') }.to raise_error(described_class::InvalidURNError, 'bad URN(is not URN?): urn:urn:1234')
    end

    it 'returns the same URN if the argument is a URN' do
      urn = URN.new('urn:foo:bar')

      expect(URN(urn).to_s).to eq('urn:foo:bar')
    end
  end

  describe '#initialize' do
    it 'returns the same URN if the argument is a URN' do
      urn = URN.new('urn:foo:bar')

      expect(URN.new(urn).to_s).to eq('urn:foo:bar')
    end

    it 'returns a URN if it is valid' do
      expect(described_class.new('urn:namespace:specificstring')).to be_kind_of(described_class)
    end

    it 'raise InvalidURNError if it is not valid' do
      expect { described_class.new('urn:urn:1234') }.to raise_error(described_class::InvalidURNError, 'bad URN(is not URN?): urn:urn:1234')
    end

    it 'returns a URN if namespace includes urn' do
      expect(described_class.new('urn:urnnamespace:specificstring')).to be_kind_of(described_class)
    end

    it 'raises an error if it does not start with urn' do
      expect { described_class.new('not-urn:namespace:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'raises an error if namespace is urn' do
      expect { described_class.new('urn:urn:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'raises an error if namespace is URN' do
      expect { described_class.new('urn:URN:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns true if the namespace identifier is 32 characters long' do
      nid = 'a' * 32

      expect(described_class.new("urn:#{nid}:bar")).to be_kind_of(described_class)
    end

    it 'raises an error if the namespace identifier begins with a hyphen' do
      expect { described_class.new('urn:-foo:bar') }.to raise_error(described_class::InvalidURNError)
    end

    it 'raises an error if the namespace specific string has invalid escaping' do
      expect { described_class.new('urn:foo:bar%2') }.to raise_error(described_class::InvalidURNError)
    end

    it 'raises an error if the namespace specific string has reserved characters' do
      expect { described_class.new('urn:foo:café') }.to raise_error(described_class::InvalidURNError)
    end

    it 'raises an error if the namespace specific string has a not allowed hexadecimal value' do
      expect { described_class.new('urn:foo:abc%10') }.to raise_error(described_class::InvalidURNError)
    end
  end

  describe '#normalize' do
    it 'lowercases the leading "urn:" token' do
      expect(described_class.new('URN:foo:123').normalize.to_s).to eq('urn:foo:123')
    end

    it 'lowercases the namespace identifier' do
      expect(described_class.new('urn:FOO:123').normalize.to_s).to eq('urn:foo:123')
    end

    it 'lowercases %-escaping in the namespace specific string' do
      expect(described_class.new('urn:foo:123%2C456').normalize.to_s).to eq('urn:foo:123%2c456')
    end

    it 'does not lowercase other characters in the namespace specific string' do
      expect(described_class.new('urn:foo:BA%2CR').normalize.to_s).to eq('urn:foo:BA%2cR')
    end
  end

  describe '#nid' do
    it 'returns the namespace identifier' do
      expect(described_class.new('urn:namespace:specificstring').nid).to eq('namespace')
    end
  end

  describe '#nss' do
    it 'returns the namespace specific string' do
      expect(described_class.new('urn:namespace:specificstring').nss).to eq('specificstring')
    end
  end

  describe '#to_s' do
    it 'returns the string representation of the URN' do
      expect(described_class.new('urn:Name:Spec').to_s).to eq('urn:Name:Spec')
    end
  end

  describe '#===' do
    it 'returns true if the string is an equivalent valid URN' do
      expect(described_class.new('urn:name:spec') === 'URN:Name:spec').to be(true)
    end

    it 'returns true if the normalized object of the other class is equal' do
      expect(described_class.new('urn:name:spec') === URI('urn:name:spec')).to be(true)
    end

    it 'returns true if the URN object is an equivalent valid URN' do
      expect(described_class.new('urn:name:spec') === described_class.new('URN:Name:spec')).to be(true)
    end

    it 'returns false if the URN is not equivalent' do
      expect(described_class.new('urn:name:spec') === described_class.new('URN:Name:SPEC')).to be(false)
    end

    it 'return false if the URN is not valid' do
      expect(described_class.new('urn:name:spec') === 'urn:urn:urn').to be(false)
    end
  end

  describe '#==' do
    it 'returns true if the URN object is an equivalent valid URN' do
      expect(described_class.new('urn:name:spec')).to eq(described_class.new('URN:Name:spec'))
    end

    it 'returns false if the argument is not a URN object' do
      expect(described_class.new('urn:name:spec')).not_to eq('urn:name:spec')
    end
  end

  describe '#eql?' do
    it 'returns true if both URNs are equal' do
      expect(described_class.new('urn:Name:Spec')).to eql(described_class.new('urn:Name:Spec'))
    end

    it 'returns false if the URNs are not equal' do
      expect(described_class.new('urn:name:spec')).not_to eql(described_class.new('urn:Name:spec'))
    end
  end

  describe '.extract' do
    it 'extracts the URNs from a string' do
      str = 'En un pueblo italiano urn:1234:abc al pie de la montaña URN:foo:bar%23.\\'

      expect(URN.extract(str)).to contain_exactly('urn:1234:abc', 'URN:foo:bar%23.')
    end

    it 'extracts the URNs from a string using a block' do
      str = 'Llum, foc, destrucció. urn:foo:%10 El món pot ser només una runa, URN:FOO:BA%2cR això no ho consentirem.'

      normalized_urns = []
      URN.extract(str) { |urn| normalized_urns << URN(urn).normalize.to_s }

      expect(normalized_urns).to contain_exactly('urn:foo:BA%2cR')
    end

    it 'only extracts URNs with word boundaries at the beginning' do
      expect(URN.extract('sideburn:mutton:chops')).to be_empty
    end
  end
end
