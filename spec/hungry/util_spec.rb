require 'spec_helper'

describe Hungry::Util do
  describe '#params_from_uri' do
    it 'returns a hash representing the params in the given URL' do
      hash = Hungry::Util.params_from_uri 'http://www.google.com/search?q=ruby&lang=en'
      hash.should == { 'q' => 'ruby', 'lang' => 'en' }
    end
  end
  
  describe '#uri_with_params' do
    it 'returns a clean URL if there no hash is given' do
      url = Hungry::Util.uri_with_params('http://www.google.com/')
      url.should == 'http://www.google.com/'
    end
    
    it 'returns an URL with params representing the given hash' do
      url = Hungry::Util.uri_with_params('http://www.google.com/search', 'q' => 'ruby', 'lang' => 'en')
      url.should == 'http://www.google.com/search?q=ruby&lang=en'
    end
  end
  
  describe '#is_numeric?' do
    it 'returns true for integers' do
      Hungry::Util.is_numeric?(100).should be_true
    end

    it 'returns true for floats' do
      Hungry::Util.is_numeric?(10.0).should be_true
    end

    it 'returns true for integers in strings' do
      Hungry::Util.is_numeric?('100').should be_true
    end

    it 'returns true for floats in strings' do
      Hungry::Util.is_numeric?('10.0').should be_true
    end

    it 'returns true for negative integers in strings' do
      Hungry::Util.is_numeric?('-100').should be_true
    end

    it 'returns true for negative floats in strings' do
      Hungry::Util.is_numeric?('-10.0').should be_true
    end

    it 'returns false for non numeric values' do
      Hungry::Util.is_numeric?('abc').should be_false
      Hungry::Util.is_numeric?('1a3').should be_false
      Hungry::Util.is_numeric?('1.0.0').should be_false
    end
  end
end