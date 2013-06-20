module Hungry
  class Review < Resource
    
    ### ATTRIBUTES:
    
                  ### Review:
    attr_accessor :id, :body, :rating, :scores, :author,
                  
                  ### Utility:
                  :created_at, :updated_at
    
    ### RESOURCES:
    
    belongs_to :venue, Hungry::Venue
    
  end
end
