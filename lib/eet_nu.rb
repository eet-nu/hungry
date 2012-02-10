require 'active_support/core_ext/hash/keys'

$LOAD_PATH << File.expand_path('..', __FILE__)

module EetNu
  VERSION = '0.0.1'
  API_URL = 'api.eet.nu'
  
  autoload :Review, 'eet_nu/review'
  autoload :Venue,  'eet_nu/venue'
  
  # Exception raised when a geolocation is required, but it is not givenå
  class GeolocationNotGiven < StandardError; end
end
