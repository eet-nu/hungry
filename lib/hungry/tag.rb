module Hungry
  class Tag < Resource
    
    self.endpoint = '/tags'
    
    ### ATTRIBUTES:
    
                  ### Tag:
    attr_accessor :id, :name, :context,
                  
                  ### Utility:
                  :resources, :counters
    
    ### RESOURCES:
    
    has_many :venues, 'Hungry::Venue'
    
    has_many :tags, 'Hungry::Tag'
    
  end
end
