module Hungry
  class Tag < Resource

    self.endpoint = '/tags'

    ### RESOURCES:

    has_many :venues, 'Hungry::Venue'

    has_many :tags, 'Hungry::Tag'

    ### ATTRIBUTES:

                  ### Tag:
    attr_accessor :id, :name, :context,

                  ### Utility:
                  :resources, :counters
  end
end
