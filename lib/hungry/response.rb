module Hungry
  class Response < Resource

    ### RESOURCES:

    belongs_to :review, 'Hungry::Review'

    ### ATTRIBUTES:

                  ### Review:
    attr_accessor :id, :body, :author,

                  ### Utility:
                  :created_at, :updated_at

  end
end
