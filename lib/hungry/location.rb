module Hungry
  class Location < Resource

    self.endpoint = '/locations'

    ### RESOURCES:

    has_many :venues, 'Hungry::Venue'

    has_many :nearby_venues, 'Hungry::Venue'

    has_many :tags, 'Hungry::Tag'

    ### ATTRIBUTES:

                  ### Location:
    attr_accessor :id, :name, :type, :url, :geolocation,

                  ### Utility:
                  :resources, :counters

    def geolocation=(new_coordinates)
      @geolocation = Geolocation.parse(new_coordinates).tap do |geo|
        attributes[:geolocation] = geo
      end
    end

    %w[created_at updated_at].each do |method|
      define_method("#{method}=") do |new_value|
        parsed_value = new_value.present? ? Time.parse(new_value) : nil
        instance_variable_set("@#{method}", parsed_value)
      end
    end
  end
end
