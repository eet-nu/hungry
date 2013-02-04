require 'httparty'

module Hungry
  class Resource
    include HTTParty
    
    attr_accessor :attributes
    
    ### CLASS METHODS:
    
    def self.get(*args)
      puts "[Resource]: GET #{args.map(&:inspect).join(', ')}"
      self.base_uri Hungry.api_url
      super
    end
    
    def self.belongs_to(resource, klass = Resource)
      define_method resource do
        if url = resources[resource]
          attributes = self.class.get url
          klass.new(attributes)
        end
      end
    end
    
    def self.has_many(resource, klass = Resource)
      define_method resource do
        if url = resources[resource]
          klass.collection.from_url(url)
        end
      end
    end
    
    class << self
      include Enumerable
      
      attr_writer :endpoint
      attr_writer :default_criteria
      
      def endpoint
        @endpoint || (superclass.respond_to?(:endpoint) ? superclass.endpoint : nil)
      end
      
      def default_criteria
        if @default_criteria.respond_to?(:call)
          @default_criteria.call
        else
          @default_criteria || {}
        end
      end
      
      def collection
        Collection.new(self, endpoint, default_criteria)
      end
      
      def find(id)
        raise NoEndpointSpecified unless endpoint
        
        response = get "#{endpoint}/#{id}"
        
        if response.code == 200
          new(response)
        end
      end
      
      def all(criteria = {})
        collection.all(criteria)
      end
      
      def each(&block)
        all.each(&block)
      end
    end
    
    ### INSTANCE METHODS:
    
    def initialize(new_attributes = {})
      self.attributes = {}
      
      new_attributes.each do |key, value|
        if value.respond_to?(:symbolize_keys)
          value = value.symbolize_keys
        end
        
        attributes[key] = value
        
        if respond_to?("#{key}=")
          send("#{key}=", value)
        end
      end
    end
  end
end