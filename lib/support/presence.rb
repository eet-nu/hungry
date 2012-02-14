begin
  # Add support for Object#presence:
  require 'active_support/core_ext/object/blank'

rescue LoadError => e
  Object.class_eval do
    unless respond_to?(:presence)
      def presence
        return nil if respond_to?(:empty?) ? empty? : !self
        self
      end
    end
  end
end
