require 'spec_helper'

describe EetNu::Venue do
  describe '.find' do
    context 'with valid ID' do
      use_vcr_cassette
      
      subject { EetNu::Venue.find(31335) }
      
      it 'finds a venue' do
        subject.should be_a EetNu::Venue
      end
      
      it "sets the venue's attributes" do
        subject.name.should include 'i76'
      end
    end
    
    context 'with invalid ID' do
      use_vcr_cassette
      
      subject { EetNu::Venue.find(1024 ** 4) }
      
      it 'returns nil' do
        subject.should be_nil
      end
    end
  end
  
  describe '.search' do
    use_vcr_cassette
    
    it 'finds matching venues' do
      results = EetNu::Venue.search("beluga")
      results[0].name.should include 'Beluga'
    end
  end
  
  describe '.nearby' do
    use_vcr_cassette
    
    it 'finds nearby venues' do
      results = EetNu::Venue.nearby(50.8461267, 5.6996659)
      results[0].name.should include 'Beluga'
    end
  end
  
  describe '#initialize' do
    it "sets the venue's attributes" do
      venue = EetNu::Venue.new name: 'i76'
      venue.name.should == 'i76'
    end
    
    it "maps accessiblity to accessibility" do
      venue = EetNu::Venue.new accessiblity: 'mapped'
      venue.accessibility.should == 'mapped'
    end
    
    it "maps image_urls to images" do
      venue = EetNu::Venue.new image_urls: ['http://www.google.com/']
      venue.images.should == ['http://www.google.com/']
    end
    
    it "maps pro_ratings to awards" do
      venue = EetNu::Venue.new pro_ratings: { michelin_stars: 2 }
      venue.awards.should == { michelin_stars: 2 }
    end
  end
end
