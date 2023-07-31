module Hungry
  class Menu < Resource
    autoload :Category, 'hungry/menu/category'
    autoload :Dish,     'hungry/menu/dish'
    autoload :Option,   'hungry/menu/option'

    self.endpoint = '/menus'

    ### RESOURCES:

    belongs_to :venue, 'Hungry::Venue'

    ### ATTRIBUTES:

                  ### Menu:
    attr_accessor :id, :name, :type, :attachment, :pages,

                  ### Associations:
                  :categories, :venue,

                  ### Utility:
                  :created_at, :updated_at

    lazy_load :venue

    def managed?
      type == 'managed' || (!download? && categories.present?)
    end

    def download?
      type == 'download'
    end

    def venue=(venue_attributes)
      @venue = Hungry::Venue.new(venue_attributes)
    end

    def categories
      @categories ||= []
    end
    lazy_load :categories

    def categories=(new_categories)
      @categories = new_categories.map do |attributes|
        category = Menu::Category.new(attributes)
        category.menu        = self
        category.data_source = data_source
        category
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
