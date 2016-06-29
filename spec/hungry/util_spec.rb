require 'spec_helper'

describe Hungry::Util do
  describe '#params_from_uri' do
    it 'returns a hash representing the params in the given URL' do
      hash = Hungry::Util.params_from_uri 'http://www.google.com/search?q=ruby&lang=en'
      expect(hash).to include 'q' => 'ruby', 'lang' => 'en'
    end
  end
  
  describe '#uri_with_params' do
    it 'returns a clean URL if there no hash is given' do
      url = Hungry::Util.uri_with_params('http://www.google.com/')
      expect(url).to eql 'http://www.google.com/'
    end
    
    it 'returns an URL with params representing the given hash' do
      url = Hungry::Util.uri_with_params('http://www.google.com/search', 'q' => 'ruby', 'lang' => 'en')
      expect(url).to eql 'http://www.google.com/search?q=ruby&lang=en'
    end
  end
  
  describe '#is_numeric?' do
    it 'returns true for integers' do
      expect(Hungry::Util.is_numeric?(100)).to be true
    end
    
    it 'returns true for floats' do
      expect(Hungry::Util.is_numeric?(10.0)).to be true
    end
    
    it 'returns true for integers in strings' do
      expect(Hungry::Util.is_numeric?('100')).to be true
    end
    
    it 'returns true for floats in strings' do
      expect(Hungry::Util.is_numeric?('10.0')).to be true
    end
    
    it 'returns true for negative integers in strings' do
      expect(Hungry::Util.is_numeric?('-100')).to be true
    end
    
    it 'returns true for negative floats in strings' do
      expect(Hungry::Util.is_numeric?('-10.0')).to be true
    end
    
    it 'returns false for non numeric values' do
      expect(Hungry::Util.is_numeric?('abc')).to   be false
      expect(Hungry::Util.is_numeric?('1a3')).to   be false
      expect(Hungry::Util.is_numeric?('1.0.0')).to be false
    end
  end
end