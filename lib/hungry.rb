$LOAD_PATH << File.expand_path('..', __FILE__)
  
require 'support/presence'
require 'support/symbolize_keys'

module Hungry
  VERSION = '0.1.1'
  
  class << self
    attr_accessor :api_url, :credentials, :json_parser, :logger
  end
  
  def self.credentials=(new_credentials = {})
    @credentials = new_credentials.symbolize_keys
    
    Resource.basic_auth   credentials[:username], credentials[:password]
    Collection.basic_auth credentials[:username], credentials[:password]
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
  autoload :Menu,        'hungry/menu'
  autoload :Region,      'hungry/region'
  autoload :Review,      'hungry/review'
  autoload :Response,    'hungry/response'
  autoload :Site,        'hungry/site'
  autoload :Tag,         'hungry/tag'
  autoload :User,        'hungry/user'
  autoload :Venue,       'hungry/venue'
  
  ### EXCEPTIONS:
  
  # Exception raised when a geolocation is required, but it is not given:
  class GeolocationNotGiven  < StandardError; end
  
  # Exception raised when an endpoint is not specified for a resource:
  class EndpointNotSpecified < StandardError; end
  
  ### CONFIGURATION:
  
  self.credentials = { username: nil, password: nil }
  self.api_url     = 'https://api.eet.nu/'
  self.json_parser = lambda do |json|
                       require 'json'
                       JSON.parse(json)
                     end
end
