module EetNu
  VERSION = '0.0.1'
  API_URL = 'www.eet.nu/api'
  
  autoload :Venue, 'eet_nu/venue'
  
  # Exception raised when a location (lat,lng) is required, but it is not given
  class LocationNotGiven < StandardError; end
end
