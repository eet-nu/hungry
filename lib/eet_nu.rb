require 'eet_nu/version'

module EetNu
  autoload :Venue, 'eet_nu/venue'
  
  # Exception raised when a location (lat,lng) is required, but it is not given
  class LocationNotGiven < StandardError; end
end
