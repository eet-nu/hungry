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
  
  describe '.all' do
    use_vcr_cassette
    
    it 'finds 8 venues' do
      results = EetNu::Venue.all
      results.length.should have(8).venues
    end
  end
  
  describe '.search' do
    use_vcr_cassette
    
    it 'finds matching venues' do
      results = EetNu::Venue.search('beluga')
      results[0].name.should include 'Beluga'
    end
    
    context 'with sort_by: "distance"' do
      context 'with geolocation' do
        use_vcr_cassette
        
        let(:results) { EetNu::Venue.search('beluga', sort_by: 'distance', geolocation: [50.8469397, 5.6927505]) }
        
        it 'sorts matching venues by distance' do
          results.map(&:name)[0..3].should == ['Beluga Nxt Door', 'Beluga', 'Beluga Beachclub']
        end
        
        it 'sets the distance attribute' do
          results[1].distance.should >= 400
        end
      end
      
      context 'without location' do
        use_vcr_cassette
        
        it 'raises an GeolocationNotGiven exception' do
          expect {
            EetNu::Venue.search('beluga', sort_by: 'distance')
          }.to raise_error(EetNu::GeolocationNotGiven)
        end
      end
    end
    
    context 'with sort_by: "relevance"' do
      use_vcr_cassette
      
      it 'sorts matching venues by relevance' do
        results = EetNu::Venue.search('beluga', sort_by: 'relevance')
        results.map(&:name)[0..3].should == ['Beluga', 'Beluga Beachclub', 'Beluga Nxt Door']
      end
    end
  end
  
  describe '.nearby' do
    use_vcr_cassette
    
    it 'finds nearby venues' do
      results = EetNu::Venue.nearby([50.8461267, 5.6996659])
      results[0].name.should include 'Beluga'
    end
  end
  
  describe '#initialize' do
    it "sets the venue's attributes" do
      venue = EetNu::Venue.new name: 'i76'
      venue.name.should == 'i76'
    end
  end
  
  describe '#reviews' do
    use_vcr_cassette
    
    let(:venue) { EetNu::Venue.find 21719 }
    
    it "finds the venue's reviews" do
      venue.reviews.size.should >= 10
      venue.reviews.first.should be_a EetNu::Review
    end
  end
end
