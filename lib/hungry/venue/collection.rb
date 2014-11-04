require_relative '../collection'

module Hungry
  class Venue
    class Collection < Hungry::Collection
      include Pagination
      
      def search(query)
        all query: query
      end
      
      def nearby(location, options = {})
        options[:geolocation]   = Geolocation.parse(location)
        options[:sort_by]     ||= 'distance'
        
        all options
      end
      
      def tagged_with(*tags)
        all tags: (current_tags + tags.flatten).compact.join(',')
      end
      
      def maintainable_by(user_or_id)
        user_id = user_or_id.to_s =~ /^[0-9]+$/ ?
                    user_or_id.to_i : user_or_id.id
        
        all maintainer_id: user_id
      end
      
      def sort_by(subject)
        all sort_by: subject
      end
      
      private
      
      def current_tags
        if criteria[:tags].is_a?(String)
          criteria[:tags].gsub(/\s+/, '')
                         .split(',')
        else
          criteria[:tags] || []
        end
      end
    end
  end
end
