require 'spec_helper'

describe EetNu::Util do
  describe '#is_numeric?' do
    it 'returns true for integers' do
      EetNu::Util.is_numeric?(100).should be_true
    end

    it 'returns true for floats' do
      EetNu::Util.is_numeric?(10.0).should be_true
    end

    it 'returns true for integers in strings' do
      EetNu::Util.is_numeric?('100').should be_true
    end

    it 'returns true for floats in strings' do
      EetNu::Util.is_numeric?('10.0').should be_true
    end

    it 'returns true for negative integers in strings' do
      EetNu::Util.is_numeric?('-100').should be_true
    end

    it 'returns true for negative floats in strings' do
      EetNu::Util.is_numeric?('-10.0').should be_true
    end

    it 'returns false for non numeric values' do
      EetNu::Util.is_numeric?('abc').should be_false
      EetNu::Util.is_numeric?('1a3').should be_false
      EetNu::Util.is_numeric?('1.0.0').should be_false
    end
  end
end