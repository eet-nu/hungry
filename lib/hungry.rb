if defined?(Motion::Project::Config)
  Motion::Project::App.setup do |app|
    Dir.glob(File.join(File.dirname(__FILE__), '**/*.rb')).each do |file|
      app.files.unshift(file)
    end
  end
else
  $LOAD_PATH << File.expand_path('..', __FILE__)
  
  require 'support/presence'
  require 'support/symbolize_keys'
end

module Hungry
  VERSION = '0.0.1'
  
  class << self
    attr_accessor :api_url, :json_parser
  end
  
  self.api_url     = 'http://api.eet.nu/'
  self.json_parser = lambda do |json|
                       require 'json'
                       JSON.parse(json)
                     end
  
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
