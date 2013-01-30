require 'httparty'

module Hungry
  class Review
    include HTTParty
    
    base_uri Hungry::API_URL
    
                  ### Venue:
    attr_accessor :id, :body, :rating, :scores, :author,
                  
                  ### Utility:
                  :created_at, :updated_at
    
    # # Returns a single review specified by the id parameter
    # def self.find(id)
    #   response = get "/reviews/#{id}"
    #
    #   Review.new(response) if response.code == 200
    # end
    #
    # # Return the 25 latest reviews
    # def self.latest
    #   response = get "/reviews"
    #   response.map do |attributes|
    #     Review.new(attributes)
    #   end
    # end
    
    def initialize(attributes = {})
      attributes.each do |key, value|
        value.symbolize_keys! if value.respond_to?(:symbolize_keys!)
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
  end
end
