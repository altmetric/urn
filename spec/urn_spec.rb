# encoding: utf-8
require 'urn'

RSpec.describe URN do
  describe 'Kernel.URN' do
    it 'returns a URN if it is valid' do
      expect(URN('urn:namespace:specificstring')).to be_kind_of(described_class)
    end

    it 'raise InvalidURNError if it is not valid' do
      expect { URN('urn:urn:1234') }.to raise_error(described_class::InvalidURNError, 'bad URN(is not URN?): urn:urn:1234')
    end
  end

  describe '#initialize' do
    it 'returns a URN if it is valid' do
      expect(described_class.new('urn:namespace:specificstring')).to be_kind_of(described_class)
    end

    it 'raise InvalidURNError if it is not valid' do
      expect { described_class.new('urn:urn:1234') }.to raise_error(described_class::InvalidURNError, 'bad URN(is not URN?): urn:urn:1234')
    end

    it 'returns a URN if namespace includes urn' do
      expect(described_class.new('urn:urnnamespace:specificstring')).to be_kind_of(described_class)
    end

    it 'returns error if it does not start with urn' do
      expect { described_class.new('not-urn:namespace:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns error if namespace is urn' do
      expect { described_class.new('urn:urn:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns error if namespace is URN' do
      expect { described_class.new('urn:URN:specificstring') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns true if the namespace identifier is 32 characters long' do
      nid = 'a' * 32

      expect(described_class.new("urn:#{nid}:bar")).to be_kind_of(described_class)
    end

    it 'returns error if the namespace identifier begins with a hyphen' do
      expect { described_class.new('urn:-foo:bar') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns error if the namespace specific string has invalid escaping' do
      expect { described_class.new('urn:foo:bar%2') }.to raise_error(described_class::InvalidURNError)
    end

    it 'returns error if the namespace specific string has reserved characters' do
      expect { described_class.new('urn:foo:café') }.to raise_error(described_class::InvalidURNError)
    end
  end

  describe '#normalize' do
    it 'lowercases the leading "urn:" token' do
      expect(described_class.new('URN:foo:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases the namespace identifier' do
      expect(described_class.new('urn:FOO:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases %-escaping in the namespace specific string' do
      expect(described_class.new('urn:foo:123%2C456').normalize).to eq('urn:foo:123%2c456')
    end

    it 'does not lowercase other characters in the namespace specific string' do
      expect(described_class.new('urn:foo:BA%2CR').normalize).to eq('urn:foo:BA%2cR')
    end
  end
end
