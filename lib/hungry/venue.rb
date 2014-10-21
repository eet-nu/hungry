module Hungry
  class Venue < Resource
    autoload :Collection, 'hungry/venue/collection'
    
    self.endpoint = '/venues'
    
    ### RESOURCES:
    
    has_many :reviews, 'Hungry::Review'
    
    belongs_to :country, 'Hungry::Country'
    
    belongs_to :region, 'Hungry::Region'
    
    belongs_to :city, 'Hungry::City'
    
    ### FINDERS:
    
    def self.collection
      Collection.new(self, endpoint, default_criteria)
    end
    
    def self.search(query)
      collection.search(query)
    end
    
    def self.nearby(geolocation, options = {})
      collection.nearby(geolocation, options)
    end
    
    def self.tagged_with(*tags)
      collection.tagged_with(*tags)
    end
    
    def self.sort_by(sortable)
      collection.sort_by(sortable)
    end
    
    def self.paginate(page, options = {})
      collection.paginate(page, options)
    end
    
    ### ATTRIBUTES:
    
                  ### Preview:
    attr_accessor :id, :name, :category, :telephone, :fax, :website_url,
                  :tagline, :rating, :url, :address, :geolocation, :relevance,
                  :distance, :plan,
                  
                  ### Full:
                  :reachability, :staff, :prices, :capacity, :description,
                  :tags, :menus, :images, :maintainers, :awards, :opening_hours,
                  :holidays,
                  
                  ### Utility:
                  :resources,  :counters, :created_at, :updated_at
    
    def geolocation=(new_coordinates)
      @geolocation = Geolocation.parse(new_coordinates).tap do |geo|
        attributes[:geolocation] = geo
      end
    end
  end
end
