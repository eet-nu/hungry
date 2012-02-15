require 'httparty'

module EetNu
  class Venue
    include HTTParty
    
                  ### Preview:
    attr_accessor :id, :name, :category, :telephone, :fax, :website_url,
                  :tagline, :rating, :url, :address, :geolocation, :relevance,
                  :distance,
                  
                  ### Full:
                  :reachability, :staff, :prices, :capacity, :description,
                  :tags, :menus, :images, :maintainers, :awards, :opening_hours,
                  
                  ### Utility:
                  :resources,  :counters, :created_at, :updated_at
    
    base_uri EetNu::API_URL
    
    # Returns a single venue specified by the id parameter.
    def self.find(id)
      response = get "/venues/#{id}"
      
      Venue.new(response) if response.code == 200
    end
    
    # Returns all venues paginated per 100
    def self.all(options = {})
      params = options.map { |k,v| "#{k}=#{CGI.escape(v)}" }.
                       join('&')
      uri = ['/venues', params].join('?')

      response = get uri
      
      response['results'].map do |attributes|
        Venue.new(attributes)
      end
    end
    
    # Returns a maximum of 50 venues satisfying the query parameter.
    # 
    # Accepts options:
    # * `sort_by` -- can be set to "distance" or "relevance". If the order is set
    #   to "distance", the `location` option is required.
    # * `geolocation` -- an array with a latitude and longitude. Required if the
    #   results are to be sorted by distance.
    def self.search(query, options = {})
      uri = "/venues?query=#{query}"
      
      if options[:sort_by] == 'distance'
        geolocation = Geolocation.parse(options[:geolocation])
        raise GeolocationNotGiven unless geolocation
        
        uri += "&geolocation=#{geolocation}"
      end
      
      if options[:sort_by]
        uri += "&sort_by=#{options[:order]}"
      end
      
      response = get uri
      response['results'].map do |attributes|
        Venue.new(attributes)
      end
    end
    
    # Returns a maximum of 50 venues that are located near the given location.
    # Venues are ordered by distance.
    def self.nearby(geolocation)
      geolocation = Geolocation.parse(geolocation)
      
      response = get "/venues?geolocation=#{geolocation}"
      response['results'].map do |attributes|
        Venue.new(attributes)
      end
    end
    
    def initialize(attributes = {})
      attributes.each do |key, value|
        value.symbolize_keys! if value.respond_to?(:symbolize_keys!)
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    # Returns all reviews of this venue
    def reviews
      response = self.class.get resources[:reviews]
      response['results'].map do |attributes|
        Review.new(attributes)
      end
    end
  end
end
