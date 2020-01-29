require 'spec_helper'

describe Hungry::Geolocation do
  let(:geo) { Hungry::Geolocation.new(50.8469397, 5.6927505) }

  describe '.parse' do
    context 'with a Geolocation' do
      it 'returns the given Geolocation' do
        expect(Hungry::Geolocation.parse(geo)).to eql geo
      end
    end

    context 'with an Object' do
      it 'returns a Geolocation object for objects with a latitude and longitude' do
        object = Class.new do
          def latitude;  50.8469397; end
          def longitude;  5.6927505; end
        end.new

        geo = Hungry::Geolocation.parse(object)
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns a Geolocation object for objects with a lat and lng' do
        object = Class.new do
          def lat; 50.8469397; end
          def lng;  5.6927505; end
        end.new

        geo = Hungry::Geolocation.parse(object)
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns a Geolocation object for objects that have a valid geolocation' do
        object = Class.new do
          def geolocation; Hungry::Geolocation.new(50.8469397, 5.6927505); end
        end.new

        geo = Hungry::Geolocation.parse(object)
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns nil for objects without geo information' do
        geo = Hungry::Geolocation.parse(Object.new)
        expect(geo).to be_nil
      end

      it 'returns nil for objects that have an invalid geolocation' do
        object = Class.new do
          def geolocation; "just a string"; end
        end.new

        geo = Hungry::Geolocation.parse(object)
        expect(geo).to be_nil
      end
    end

    context 'with a String' do
      it 'returns a Geolocation object' do
        geo = Hungry::Geolocation.parse('50.8469397,5.6927505')
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns nil if the string can not be parsed' do
        geo = Hungry::Geolocation.parse('not-a,geolocation')
        expect(geo).to be_nil
      end
    end

    context 'with an Array' do
      it 'returns a Geolocation object' do
        geo = Hungry::Geolocation.parse([50.8469397, 5.6927505])
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns nil if the array can not be parsed' do
        geo = Hungry::Geolocation.parse(['not a', 'geolocation'])
        expect(geo).to be_nil
      end
    end

    context 'with a Hash' do
      it 'returns a Geolocation object' do
        geo = Hungry::Geolocation.parse(latitude: 50.8469397, longitude: 5.6927505)
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'supports abbreviated keys' do
        geo = Hungry::Geolocation.parse(lat: 50.8469397, lng: 5.6927505)
        expect(geo.latitude).to  eql 50.8469397
        expect(geo.longitude).to eql  5.6927505
      end

      it 'returns nil if the hash can not be parsed' do
        geo = Hungry::Geolocation.parse(a: 'b', c: 'd')
        expect(geo).to be_nil
      end
    end
  end

  describe '#initialize' do
    it 'sets latitude' do
      expect(geo.latitude).to eql 50.8469397
    end

    it 'sets longitude' do
      expect(geo.longitude).to eql 5.6927505
    end
  end

  describe '#to_s' do
    it 'joins latitude and longitude with a ","' do
      expect(geo.to_s).to eql '50.8469397,5.6927505'
    end
  end
end
