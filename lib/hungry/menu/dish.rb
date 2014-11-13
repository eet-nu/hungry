module Hungry
  class Menu
    class Dish < Resource
      
      attr_accessor :name, :price, :description, :options, :photos, :category
      
      def options
        @options ||= []
      end
      
      def options=(new_options)
        @options = new_options.map do |attributes|
          option = Menu::Option.new(attributes)
          option.dish        = self
          option.data_source = data_source
          option
        end
      end
      
    end
  end
end
