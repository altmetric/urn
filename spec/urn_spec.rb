require 'spec_helper'

describe URN do
  describe '#valid?' do
    it 'returns true if it is valid' do
      expect(described_class.new('urn:namespace:specificstring').valid?).to be(true)
    end

    it 'returns false if it is not valid' do
      expect(described_class.new('not-urn:namespace:specificstring').valid?).to be(false)
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
