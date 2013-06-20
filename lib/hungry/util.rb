require 'cgi'        unless defined?(CGI)
require 'rack/utils' unless defined?(Rack::Utils)

module Hungry
  module Util
    extend self
    
    def parse_json(json)
      Hungry.json_parser.call(json)
    end
    
    def params_from_uri(uri)
      uri = URI.parse(uri) unless uri.is_a?(URI)
      Rack::Utils.parse_query(uri.query) if uri.query.present?
    end
    
    def uri_with_params(uri, params = {})
      params = params.map { |k,v| "#{k}=#{CGI.escape(v.to_s)}" }
                     .join('&')
                     .presence
      
      [uri, params].compact
                   .join('?')
    end
    
    def is_numeric?(value)
      value.to_s =~ /^[+-]?[\d]+(\.[\d]+){0,1}$/
    end
  end
end
