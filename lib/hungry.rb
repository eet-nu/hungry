$LOAD_PATH << File.expand_path('..', __FILE__)
  
require 'support/presence'
require 'support/symbolize_keys'

module Hungry
  VERSION = '0.0.1'
  
  class << self
    attr_accessor :api_url, :json_parser, :logger
  end
  
  self.api_url     = 'http://api.eet.nu/'
  self.json_parser = lambda do |json|
                       require 'json'
                       JSON.parse(json)
                     end
  
  ### LIBRARY:
  
  # Utility:
  autoload :Collection,  'hungry/collection'
  autoload :Resource,    'hungry/resource'
  autoload :Util,        'hungry/util'
  
  # Helpers:
  autoload :Geolocation, 'hungry/geolocation'
  autoload :Location,    'hungry/location'
  
  # Models:
  autoload :City,        'hungry/city'
  autoload :Country,     'hungry/country'
  autoload :Region,      'hungry/region'
  autoload :Review,      'hungry/review'
  autoload :Response,    'hungry/response'
  autoload :Site,        'hungry/site'
  autoload :Tag,         'hungry/tag'
  autoload :Venue,       'hungry/venue'
  
  ### EXCEPTIONS:
  
  # Exception raised when a geolocation is required, but it is not given:
  class GeolocationNotGiven  < StandardError; end
  
  # Exception raised when an endpoint is not specified for a resource:
  class EndpointNotSpecified < StandardError; end
end
