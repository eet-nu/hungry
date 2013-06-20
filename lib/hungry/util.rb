require 'cgi' unless defined?(CGI)

module Hungry
  module Util
    extend self
    
    def parse_json(json)
      Hungry.json_parser.call(json)
    end
    
    def params_from_uri(uri)
      uri = URI.parse(uri) unless uri.is_a?(URI)
      parse_query(uri.query) if uri.query.present?
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
    
    private
    
    # Copied from rack/utils:
    def unescape(s, encoding = Encoding::UTF_8)
      URI.decode_www_form_component(s, encoding)
    end
    
    def parse_query(qs, d = nil, &unescaper)
      unescaper ||= method(:unescape)
      
      params = {}
      
      (qs || '').split(d ? /[#{d}] */ : /[&;] */n).each do |p|
        next if p.empty?
        k, v = p.split('=', 2).map(&unescaper)
        
        if cur = params[k]
          if cur.class == Array
            params[k] << v
          else
            params[k] = [cur, v]
          end
        else
          params[k] = v
        end
      end
      
      params
    end
  end
end
