module Hungry
  class Menu
    class Category < Resource
      
      attr_accessor :id, :name, :dishes, :menu
      
      def dishes
        @dishes ||= []
      end
      
      def dishes=(new_dishes)
        @dishes = new_dishes.map do |attributes|
          dish = Menu::Dish.new(attributes)
          dish.category    = self
          dish.data_source = data_source
          dish
        end
      end
      
    end
  end
end
