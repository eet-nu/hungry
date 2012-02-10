require 'active_support/core_ext/hash/keys'

module EetNu
  VERSION = '0.0.1'
  API_URL = 'api.eet.nu'
  
  autoload :Review, 'eet_nu/review'
  autoload :Venue,  'eet_nu/venue'
  
  # Exception raised when a location (lat,lng) is required, but it is not given
  class LocationNotGiven < StandardError; end
end
