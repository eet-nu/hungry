module Hungry
  class Site < Resource
    
    self.endpoint = '/sites'
    
    ### ATTRIBUTES:
    
                  ### Preview:
    attr_accessor :id, :name, :title, :subtitle, :identifier, :default, :locale,
                  :url, :timezone, :country, :applications,
                  
                  ### Utility:
                  :resources,  :counters
    
    ### FINDERS:
    
    def self.with_hostname(hostname)
      collection.all(hostname: hostname).first
    end
    
    ### INSTANCE METHODS:
    
    def hostname
      uri = URI.parse(url) rescue nil
      uri && uri.hostname
    end
    
  end
end
