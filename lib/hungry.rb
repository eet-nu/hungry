$LOAD_PATH << File.expand_path('..', __FILE__)

require 'support/presence'
require 'support/symbolize_keys'

module Hungry
  VERSION = '0.0.1'
  
  class << self
    attr_accessor :api_url
  end
  
  self.api_url = 'http://api.eet.nu/'
  
  ### LIBRARY:
  
  autoload :City,        'hungry/city'
  autoload :Collection,  'hungry/collection'
  autoload :Country,     'hungry/country'
  autoload :Geolocation, 'hungry/geolocation'
  autoload :Location,    'hungry/location'
  autoload :Region,      'hungry/region'
  autoload :Resource,    'hungry/resource'
  autoload :Review,      'hungry/review'
  autoload :Site,        'hungry/site'
  autoload :Tag,         'hungry/tag'
  autoload :Util,        'hungry/util'
  autoload :Venue,       'hungry/venue'
  
  ### EXCEPTIONS:
  
  # Exception raised when a geolocation is required, but it is not given:
  class GeolocationNotGiven  < StandardError; end
  
  # Exception raised when an endpoint is not specified for a resource:
  class EndpointNotSpecified < StandardError; end
end
