# Add support for #symbolize_keys
require 'active_support/core_ext/hash/keys'
# Add support for #presence
require 'active_support/core_ext/object/blank'

$LOAD_PATH << File.expand_path('..', __FILE__)

module EetNu
  VERSION = '0.0.1'
  API_URL = 'api.eet.nu'
  
  autoload :Geolocation, 'eet_nu/geolocation'
  autoload :Review,      'eet_nu/review'
  autoload :Util,        'eet_nu/util'
  autoload :Venue,       'eet_nu/venue'
  
  # Exception raised when a geolocation is required, but it is not givenå
  class GeolocationNotGiven < StandardError; end
end
