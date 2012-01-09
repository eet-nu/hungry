require 'httparty'

module EetNu
  class Venue
    include HTTParty
    
    MAPPING = {
      accessiblity: :accessibility,
      image_urls:   :images,
      pro_ratings:  :awards
    }
    
    attr_accessor :id, :name, :address, :location, :tags, :ratings, :awards,
                  :main_kitchen, :kitchens, :staff, :prices, :capacity,
                  :accessibility, :opening_hours, :images, :menus, :distance,
                  :maintainer_ids, :reviews_count, :image_count, :menu_count
    
    base_uri EetNu::API_URL
    
    # Returns a single venue specified by the id parameter.
    def self.find(id)
      response = get "/venues/#{id}"
      
      Venue.new(response) if response.code == 200
    end
    
    # Returns a maximum of 50 venues satisfying the query parameter.
    # 
    # Accepts options:
    # * `order` -- can be set to "distance" or "relevance". If the order is set
    #   to "distance", the `location` option is required.
    # * `location` -- an array with a latitude and longitude. Required if the
    #   results are to be sorted by distance.
    def self.search(query, options = {})
      uri = "/venues/search?query=#{query}"
      
      if options[:order] == 'distance'
        raise LocationNotGiven unless options[:location] && options[:location].size == 2
        lat, lng = options[:location]
        
        uri += "&lat=#{lat}&lng=#{lng}"
      end
      
      if options[:order]
        uri += "&order_by=#{options[:order]}"
      end
      
      response = get uri
      response.map do |attributes|
        Venue.new(attributes)
      end
      
    end
    
    # Returns a maximum of 50 venues that are located near the given location.
    # Venues are ordered by distance.
    def self.nearby(latitude, longitude)
      response = get "/venues/nearby?lat=#{latitude}&lng=#{longitude}"
      response.map do |attributes|
        Venue.new(attributes)
      end
    end
    
    def initialize(attributes = {})
      MAPPING.each do |from, to|
        if value = attributes.delete(from)
          attributes[to] = value
        end
      end
      
      attributes.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    # Returns all reviews of this venue
    def reviews
      response = self.class.get "/venues/#{id}/reviews"
      response.map do |attributes|
        Review.new(attributes)
      end
    end
  end
end
