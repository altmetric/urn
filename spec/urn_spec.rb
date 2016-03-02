require 'spec_helper'

describe URN do
  describe '#valid?' do
    context 'returns true' do
      it 'if it is valid' do
        expect(described_class.new('urn:namespace:specificstring').valid?).to be(true)
      end

      it 'if namespace includes urn' do
        expect(described_class.new('urn:urnnamespace:specificstring').valid?).to be(true)
      end
    end

    context 'returns false' do
      it 'if it does not start with urn' do
        expect(described_class.new('not-urn:namespace:specificstring').valid?).to be(false)
      end

      it 'if namespace is urn' do
        expect(described_class.new('urn:urn:specificstring').valid?).to be(false)
      end
    end
  end

  describe '#normalize' do
    it 'lowercases the urn and namespace identifier parts only' do
      expect(described_class.new('URN:NameSpace:SpecificString').normalize).to eq('urn:namespace:SpecificString')
    end

    it 'returns nil if it is not valid' do
      expect(described_class.new('urn:').normalize).to be_nil
    end
  end
end
