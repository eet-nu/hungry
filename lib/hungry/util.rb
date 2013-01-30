module Hungry
  module Util
    extend self
    
    def is_numeric?(value)
      value.to_s =~ /^[+-]?[\d]+(\.[\d]+){0,1}$/
    end
  end
end
