begin
  # Add support for Hash#symbolize_keys:
  require 'active_support/core_ext/hash/keys'

rescue LoadError => e
  Hash.class_eval do
    unless respond_to?(:symbolize_keys)
      def symbolize_keys
        inject({}) do |options, (key, value)|
          options[(key.to_sym rescue key) || key] = value
          options
        end
      end
    end
  end
end
