require 'httparty'
require 'cgi'

module Hungry
  class Collection
    include Enumerable
    include HTTParty
    
    autoload :Pagination, 'hungry/collection/pagination'
    
    attr_reader :klass, :endpoint, :criteria
    
    ### CLASS METHODS:
    
    def self.get(*args)
      self.base_uri Hungry.api_url
      super
    end
    
    ### INSTANCE METHODS:
    
    def initialize(klass, endpoint, criteria = {})
      @klass    = klass
      @endpoint = endpoint
      @criteria = criteria.symbolize_keys
    end
    
    def from_url(url)
      uri     = URI.parse(url)
      options = Util.params_from_uri(uri) || klass.default_criteria
      
      self.class.new(klass, uri.path, options)
    end
    
    def all(new_criteria = {})
      self.class.new(klass, endpoint, criteria.merge(new_criteria))
    end
    
    def count(*args)
      if args.present?
        super
      else
        response['results'].count
      end
    end
    
    def each(&block)
      response['results'].each do |result|
        yield klass.new(result)
      end
    end
    
    private
    
    def response
      raise NoEndpointSpecified unless endpoint
      
      @response ||= begin
        uri = Util.uri_with_params(endpoint, criteria)
        self.class.get uri
      end
    end
  end
end
