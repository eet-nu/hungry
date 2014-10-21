module Hungry
  class Location < Resource
    
    self.endpoint = '/locations'
    
    ### RESOURCES:
    
    has_many :venues, 'Hungry::Venue'
    
    has_many :nearby_venues, 'Hungry::Venue'
    
    has_many :tags, 'Hungry::Tag'
    
    ### ATTRIBUTES:
    
                  ### Location:
    attr_accessor :id, :name, :type, :url, :geolocation,
                  
                  ### Utility:
                  :resources, :counters
  end
end
