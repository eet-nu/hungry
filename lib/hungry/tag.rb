module Hungry
  class Tag < Resource
    
    self.endpoint = '/tags'
    
    ### ATTRIBUTES:
    
                  ### Tag:
    attr_accessor :id, :name, :context,
                  
                  ### Utility:
                  :resources, :counters
    
    ### RESOURCES:
    
    has_many :venues, Venue
    
    has_many :tags, Tag
    
  end
end
