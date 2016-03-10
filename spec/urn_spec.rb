# encoding: utf-8
require 'urn'

RSpec.describe URN do
  describe '#valid?' do
    it 'returns true if it is valid' do
      expect(described_class.new('urn:namespace:specificstring')).to be_valid
    end

    it 'returns true if namespace includes urn' do
      expect(described_class.new('urn:urnnamespace:specificstring')).to be_valid
    end

    it 'returns false if it does not start with urn' do
      expect(described_class.new('not-urn:namespace:specificstring')).not_to be_valid
    end

    it 'returns false if namespace is urn' do
      expect(described_class.new('urn:urn:specificstring')).not_to be_valid
    end

    it 'returns false if namespace is URN' do
      expect(described_class.new('urn:URN:specificstring')).not_to be_valid
    end

    it 'returns true if the namespace identifier is 32 characters long' do
      nid = 'a' * 32

      expect(described_class.new("urn:#{nid}:bar")).to be_valid
    end

    it 'returns false if the namespace identifier begins with a hyphen' do
      expect(described_class.new('urn:-foo:bar')).not_to be_valid
    end

    it 'returns false if the namespace specific string has invalid escaping' do
      expect(described_class.new('urn:foo:bar%2')).not_to be_valid
    end

    it 'returns false if the namespace specific string has reserved characters' do
      expect(described_class.new('urn:foo:café')).not_to be_valid
    end
  end

  describe '#normalize' do
    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').normalize).to be_nil
    end

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

  describe '#==' do
    let(:foo) { described_class.new('URN:foo:123') }
    let(:foo_eq) { described_class.new('urn:FOO:123') }
    let(:bar) { described_class.new('urn:bar:123') }

    it 'returns true if both URNs are equivalent' do
      expect(foo).to eq(foo_eq)
    end

    it 'returns false when both URNs are not equivalent' do
      expect(foo).not_to eq(bar)
    end
  end
end
