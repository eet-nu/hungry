$LOAD_PATH << File.expand_path('..', __FILE__)

require 'support/presence'
require 'support/symbolize_keys'

module Hungry
  VERSION = '0.0.1'
  API_URL = 'api.eet.nu'
  
  autoload :Geolocation, 'hungry/geolocation'
  autoload :Review,      'hungry/review'
  autoload :Util,        'hungry/util'
  autoload :Venue,       'hungry/venue'
  
  # Exception raised when a geolocation is required, but it is not givenå
  class GeolocationNotGiven < StandardError; end
end
