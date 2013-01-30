require 'spec_helper'

describe Hungry::Venue do
  describe '.find' do
    context 'with valid ID' do
      subject { Hungry::Venue.find(31335) }
      
      xit 'finds a venue' do
        subject.should be_a Hungry::Venue
      end
      
      xit "sets the venue's attributes" do
        subject.name.should include 'i76'
      end
    end
    
    context 'with invalid ID' do
      subject { Hungry::Venue.find(1024 ** 4) }
      
      xit 'returns nil' do
        subject.should be_nil
      end
    end
  end
  
  describe '.all' do
    xit 'finds 8 venues' do
      results = Hungry::Venue.all
      results.length.should have(8).venues
    end
  end
  
  describe '.search' do
    xit 'finds matching venues' do
      results = Hungry::Venue.search('beluga')
      results[0].name.should include 'Beluga'
    end
    
    context 'with sort_by: "distance"' do
      context 'with geolocation' do
        let(:results) { Hungry::Venue.search('beluga', sort_by: 'distance', geolocation: [50.8469397, 5.6927505]) }
        
        xit 'sorts matching venues by distance' do
          results.map(&:name)[0..3].should == ['Beluga Nxt Door', 'Beluga', 'Beluga Beachclub']
        end
        
        xit 'sets the distance attribute' do
          results[1].distance.should >= 400
        end
      end
      
      context 'without location' do
        it 'raises an GeolocationNotGiven exception' do
          expect {
            Hungry::Venue.search('beluga', sort_by: 'distance')
          }.to raise_error(Hungry::GeolocationNotGiven)
        end
      end
    end
    
    context 'with sort_by: "relevance"' do
      xit 'sorts matching venues by relevance' do
        results = Hungry::Venue.search('beluga', sort_by: 'relevance')
        results.map(&:name)[0..3].should == ['Beluga', 'Beluga Beachclub', 'Beluga Nxt Door']
      end
    end
  end
  
  describe '.nearby' do
    xit 'finds nearby venues' do
      results = Hungry::Venue.nearby([50.8461267, 5.6996659])
      results[0].name.should include 'Beluga'
    end
  end
  
  describe '.tagged_with' do
    xit 'finds venues tagged with visa' do
      results = Hungry::Venue.tagged_with('visa')
      
      results[0].name.should include 'AnyTyme Friture Royaal'
    end
    
    context 'with multiple tags' do
      xit 'finds venues tagged with visa and cosy' do
        results = Hungry::Venue.tagged_with(['visa', 'cosy'])
      
        results[0].name.should include 'Houben'
      end
    end
  end
  
  describe '#initialize' do
    it "sets the venue's attributes" do
      venue = Hungry::Venue.new name: 'i76'
      venue.name.should == 'i76'
    end
  end
  
  describe '#reviews' do
    let(:venue) { Hungry::Venue.find 21719 }
    
    xit "finds the venue's reviews" do
      venue.reviews.size.should >= 10
      venue.reviews.first.should be_a Hungry::Review
    end
  end
end
