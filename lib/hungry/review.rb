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

    %w[created_at updated_at open_since].each do |method|
      define_method("#{method}=") do |new_value|
        parsed_value = new_value.present? ? Time.parse(new_value) : nil
        instance_variable_set("@#{method}", parsed_value)
      end
    end

  end
end
