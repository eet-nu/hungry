require 'httparty' unless defined? HTTParty

module Hungry
  class Resource
    include HTTParty
    
    attr_accessor :attributes, :data_source
    
    ### CLASS METHODS:
    
    def self.get(*args)
      self.base_uri Hungry.api_url
      super
    end
    
    def self.belongs_to(resource, klass = 'Resource')
      define_method resource do
        klass = Kernel.const_get(klass) if klass.is_a?(String)
        
        if attributes[resource].present?
          resource = klass.new attributes[resource]
          resource.data_source = data_source
          resource
        elsif url = resources[resource]
          attributes = self.class.get url
          resource = klass.new attributes
          resource.data_source = url
          resource
        end
      end
    end
    
    def self.has_many(resource, klass = 'Resource')
      define_method resource do
        klass = Kernel.const_get(klass) if klass.is_a?(String)
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
        
        uri = "#{endpoint}/#{id}"
        
        Util.log "GET: #{uri}"
        response = get uri
        
        if response.code == 200
          attributes = Util.parse_json(response.body)
          resource = new(attributes)
          resource.data_source = uri
          resource
        end
      end
      
      def first(n = 1)
        collection.first(n)
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
