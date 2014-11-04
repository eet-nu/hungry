require 'httparty' unless defined? HTTParty

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
    
    def [](index)
      build_resource results[index]
    end
    
    def first(n = 1)
      if n == 1 && (value = results.first)
        build_resource value
      elsif n > 1
        results.first(n).map do |result|
          build_resource result
        end
      end
    end
    
    def count(*args)
      if args.present?
        super
      else
        results.count
      end
    end
    
    def each(&block)
      results.each do |result|
        yield build_resource(result)
      end
    end
    
    def results
      @results ||= json['results']
    end
    
    def results=(results)
      @results = results
    end
    
    protected
    
    def build_resource(result)
      resource = klass.new(result)
      resource.data_source = data_source
      resource
    end
    
    def data_source
      Util.uri_with_params(endpoint, criteria)
    end
    
    def json
      @json ||= Util.parse_json(response.body)
    end
    
    def response
      raise NoEndpointSpecified unless endpoint
      
      @response ||= begin
        Util.log "GET: #{data_source}"
        self.class.get data_source
      end
    end
  end
end
