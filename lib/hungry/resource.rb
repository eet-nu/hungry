require 'httparty' unless defined? HTTParty

module Hungry
  class Resource
    include HTTParty

    attr_accessor :attributes, :resources, :data_source

    ### CLASS METHODS:

    def self.get(*args)
      self.base_uri Hungry.api_url

      super
    end

    def self.belongs_to(association, klass = 'Resource')
      define_method association do
        @belongs_to ||= {}
        @belongs_to[association] ||= begin
          klass = Kernel.const_get(klass) if klass.is_a?(String)

          if attributes[association].present?
            resource = klass.new attributes[association]
            resource.data_source = data_source
            resource
          elsif url = resources[association]
            attributes = self.class.get url
            resource = klass.new attributes
            resource.data_source = url
            resource
          end
        end
      end

      define_method "#{association}=" do |object_or_attributes|
        @belongs_to ||= {}

        klass = Kernel.const_get(klass) if klass.is_a?(String)

        if object_or_attributes.is_a?(klass)
          @belongs_to[association] = object_or_attributes
        elsif object_or_attributes.present?
          self.attributes.merge!(association => object_or_attributes)
        else
          @belongs_to[association] = nil
        end

        @belongs_to[association]
      end
    end

    def self.has_many(association, klass = 'Resource')
      define_method association do
        @has_many ||= {}
        @has_many[association] ||= begin
          klass = Kernel.const_get(klass) if klass.is_a?(String)

          if url = resources[association]
            collection = klass.collection.from_url(url)

            if attributes[association].present?
              collection.results = attributes[resource]
            end

            collection
          end
        end
      end
    end

    def self.lazy_load(*attributes)
      attributes.each do |attribute|
        alias_method "#{attribute}_without_lazy_load".to_sym, attribute
        define_method attribute do
          result = send "#{attribute}_without_lazy_load".to_sym

          if !result.present? && (canonical_data_source != data_source && canonical_data_source.present?)
            reload
            send "#{attribute}_without_lazy_load".to_sym
          else
            result
          end
        end
      end
    end

    class << self
      include Enumerable

      attr_writer :endpoint
      attr_writer :default_criteria

      def endpoint
        @endpoint || (superclass.respond_to?(:endpoint) ? superclass.endpoint : nil)
      end

      def default_criteria
        if @default_criteria.respond_to?(:call)
          @default_criteria.call
        else
          @default_criteria || {}
        end
      end

      def collection
        Collection.new(self, endpoint, default_criteria)
      end

      def find(id)
        raise NoEndpointSpecified unless endpoint

        uri = "#{endpoint}/#{id}"

        Util.log "GET: #{uri}"
        response = get uri

        if response.code == 200
          attributes = Util.parse_json(response.body)
          resource = new(attributes)
          resource.data_source = uri
          resource
        end
      end

      def first(n = 1)
        collection.first(n)
      end

      def all(criteria = {})
        collection.all(criteria)
      end

      def each(&block)
        all.each(&block)
      end
    end

    ### INSTANCE METHODS:

    def initialize(new_attributes = {})
      self.attributes = {}

      new_attributes.each do |key, value|
        if value.respond_to?(:symbolize_keys)
          value = value.symbolize_keys
        end

        attributes[key] = value

        if respond_to?("#{key}=")
          send("#{key}=", value)
        end
      end
    end

    def canonical_data_source
      resources && resources[:self]
    end

    def reload
      resource = self.class.find id

      if resource
        self.data_source = resource.data_source
        initialize resource.attributes
      else
        self.data_source = nil
        initialize Hash[attributes.keys.map { |key| [key, nil] }]
      end

      @has_many   = {}
      @belongs_to = {}

      self
    end
  end
end
