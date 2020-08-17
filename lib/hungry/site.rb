module Hungry
  class Site < Resource

    self.endpoint = '/sites'

    ### FINDERS:

    def self.with_hostname(hostname)
      collection.all(hostname: hostname).first
    end

    def self.for_country(country)
      collection.all(country: country.id).first
    end

    def self.default_site
      collection.all(default: true).first
    end


    ### ATTRIBUTES:

                  ### Preview:
    attr_accessor :id, :name, :title, :subtitle, :identifier, :default, :locale,
                  :url, :email, :support_email, :timezone, :country,
                  :newsletter_list, :applications, :emails,

                  ### Utility:
                  :resources, :counters

    def hostname
      uri = URI.parse(url) rescue nil
      uri && uri.hostname
    end

  end
end
