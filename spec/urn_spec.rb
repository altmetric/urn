require 'urn'

RSpec.describe URN do
  describe '#valid?' do
    context 'returns true' do
      it 'if it is valid' do
        expect(described_class.new('urn:namespace:specificstring')).to be_valid
      end

      it 'if namespace includes urn' do
        expect(described_class.new('urn:urnnamespace:specificstring')).to be_valid
      end
    end

    context 'returns false' do
      it 'if it does not start with urn' do
        expect(described_class.new('not-urn:namespace:specificstring')).not_to be_valid
      end

      it 'if namespace is urn' do
        expect(described_class.new('urn:urn:specificstring')).not_to be_valid
      end
    end
  end

  describe '#normalize' do
    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').normalize).to be_nil
    end

    it 'lowercases the leading "urn:" token' do
      expect(described_class.new('URN:foo:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases the NID' do
      expect(described_class.new('urn:FOO:123').normalize).to eq('urn:foo:123')
    end

    it 'lowercases %-escaping' do
      expect(described_class.new('urn:foo:123%2CA456').normalize).to eq('urn:foo:123%2cA456')
    end
  end

  describe '#nid' do
    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').nid).to be_nil
    end

    it 'returns the NID from the URN' do
      expect(described_class.new('urn:foo:bar').nid).to eq('foo')
    end

    it 'returns the normalized NID from the URN' do
      expect(described_class.new('urn:FOO:bar').nid).to eq('foo')
    end
  end

  describe '#nss' do
    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').nss).to be_nil
    end

    it 'returns the NSS from the URN' do
      expect(described_class.new('urn:foo:Bar').nss).to eq('Bar')
    end

    it 'returns the normalized NID from the URN' do
      expect(described_class.new('urn:foo:Bar%2CBaz').nss).to eq('Bar%2cBaz')
    end
  end

  describe '#=' do
    it 'is only equal to other URNs' do
      expect(described_class.new('urn:foo:bar')).not_to eq('foo')
    end

    it 'is equal to itself' do
      urn = described_class.new('urn:foo:bar')

      expect(urn).to eq(urn)
    end

    it 'is equal to identical URNs' do
      expect(described_class.new('urn:foo:bar')).to eq(described_class.new('urn:foo:bar'))
    end

    it 'is equal to URNs with a differently-cased "urn:" token' do
      urn = described_class.new('URN:foo:a123,456')

      expect(urn).to eq(described_class.new('urn:foo:a123,456'))
    end

    it 'is equal to URNs with a differently-cased NID' do
      urn = described_class.new('urn:foo:a123,456')

      expect(urn).to eq(described_class.new('urn:FOO:a123,456'))
    end

    it 'is equal to URNs with differently-cased %-escaping' do
      urn = described_class.new('urn:foo:a123%2C456')

      expect(urn).to eq(described_class.new('urn:foo:a123%2c456'))
    end

    it 'is not equal to URNs with %-escaping' do
      urn = described_class.new('urn:foo:a123,456')

      expect(urn).not_to eq(described_class.new('urn:foo:a123%2c456'))
    end
  end
end
