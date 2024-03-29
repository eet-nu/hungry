module Hungry
  class Review < Resource

    ### RESOURCES:

    belongs_to :venue, 'Hungry::Venue'

    has_many :responses, 'Hungry::Response'

    ### ATTRIBUTES:

                  ### Review:
    attr_accessor :id, :body, :rating, :scores, :author,

                  ### Utility:
                  :created_at, :updated_at

  end
end
