module Hungry
  class User < Resource

    self.endpoint = '/users'

    ### ASSOCIATIONS:

    has_many :reviews, 'Hungry::Review'

    ### FINDERS:

    def self.with_ip(ip_address)
      collection.all(ip: ip_address)
    end

    ### CLASS METHODS:

    def self.authenticate_with_persistence_token(persistence_token)
      result = authenticate_via_api 'Cookie' => "persistence_token=#{persistence_token}"
      return false unless result.present?

      from_json(result)
    end

    def self.authenticate_with_perishable_token(perishable_token)
      result = authenticate_via_api query: "perishable_token=#{perishable_token}"
      return false unless result.present?

      from_json(result)
    end

    def self.from_json(json)
      new Util.parse_json(json)
    end

    def self.authenticate_via_api(options = {})
      options = {
        path:  '/account.json',
        query: nil
      }.merge(options)

      url = URI.parse(Hungry.api_url)
      url.path  = options.delete(:path)
      url.query = options.delete(:query)

      http = Net::HTTP.new(url.host, url.port)
      if url.scheme == 'https'
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      request  = Net::HTTP::Get.new(url.request_uri, options)
      response = http.request request

      if response.code.to_i == 200
        response.body
      else
        false
      end
    end

    ### ATTRIBUTES:

                  ### Preview:
    attr_accessor :id, :name, :avatar, :slug, :profile_url, :score, :bio,
                  :location, :email,

                  ### FULL:
                  :gender, :birth_date, :website_url, :persistence_token,
                  :single_access_token, :maintainer_of, :connections,
                  :device_tokens, :admin,

                  ### Utility:
                  :resources, :counters, :created_at, :updated_at, :activated_at

  end
end
