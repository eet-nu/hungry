require 'httparty'

module EetNu
  class Review
    include HTTParty
    
    base_uri EetNu::API_URL
    
    attr_accessor :id, :body, :ratings, :venue, :author
    
    # Returns a single review specified by the id parameter
    def self.find(id)
      response = get "/reviews/#{id}"
      
      Review.new(response) if response.code == 200
    end
    
    def initialize(attributes = {})
      attributes.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
  end
end
