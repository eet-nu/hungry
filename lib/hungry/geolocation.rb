module Hungry
  class Geolocation
    attr_accessor :latitude, :longitude
    
    def self.parse(input)
      # input is already a Geolocation, so we can return it early:
      return input if input.is_a?(self)

      if input.respond_to?(:geolocation)
        # input has a geolocation attribute, so try to use that one first:
        geolocation = parse(input.geolocation) 
        return geolocation if geolocation
      end
      
      coordinates = []
      
      if input.respond_to?(:latitude) && input.respond_to?(:longitude)
        # input has latitude and longitude attributes, so use those:
        coordinates = [input.latitude, input.longitude]
        
      elsif input.respond_to?(:lat) && input.respond_to?(:lng)
        # input has lat and lng attributes, so use those:
        coordinates = [input.lat, input.lng]
        
      elsif input.respond_to?(:match)
        # Example: "50.8469397,5.6927505"
        #
        # input is a String, so we can use a regular expression to extract
        # latitude and longitude:
        if match = input.match(/^([0-9\.]+),\s?([0-9\.]+)$/)
          coordinates = [match[1], match[2]]
        end
        
      elsif input.respond_to?(:keys)
        # Example: { latitude: 50.8469397, longitude: 5.6927505 }
        #
        # input is a Hash, so we can extract values with the keys:
        coordinates = [input[:latitude] || input[:lat], input[:longitude] || input[:lng]]
        
      elsif input.respond_to?(:[])
        # Example: [50.8469397, 5.6927505]
        #
        # input is an Array, so we need the first and second value:
        coordinates = input[0], input[1]
      end
      
      coordinates = coordinates.map(&:presence).compact
      
      if coordinates.length == 2 && coordinates.all? { |coordinate| Util.is_numeric?(coordinate) }
        new(*coordinates)
      end
    end
    
    def initialize(latitude, longitude)
      self.latitude  = latitude.to_f
      self.longitude = longitude.to_f
    end
    
    def to_s
      [latitude, longitude].join(',')
    end
    
    def [](key)
      to_h.send(:[], key)
    end
    
    def []=(key, value)
      case key.to_sym
      when :latitude
        self.latitude  = value.to_f
      when :longitude
        self.longitude = value.to_f
      end
    end
    
    def to_h
      {
        latitude:  latitude,
        longitude: longitude
      }
    end
  end
end
