module Hungry
  class Collection
    module Pagination
      class NotPaginatedError < StandardError; end
      
      def paginate(page, options = {})
        all options.merge(page: page)
      end
      
      def first(n = 1)
        results = all(per_page: n, page: 1).results
        
        if n == 1 && (value = results.first)
          klass.new results.first
        elsif n > 1
          results.first(n).map do |result|
            klass.new result
          end
        end
      end
      
      def paginated?
        pagination.present?
      end
      
      def per_page
        if paginated?
          pagination['per_page'].to_i
        else
          response['results'].length
        end
      end
      
      def total_entries
        if paginated?
          pagination['total_entries'].to_i
        else
          response['results'].length
        end
      end
      
      def total_pages
        if paginated?
          pagination['total_pages'].to_i
        else
          1
        end
      end
      
      def current_page
        if paginated?
          pagination['current_page'].to_i
        else
          1
        end
      end
      
      def previous_page
        current_page - 1 if paginated? && current_page > 1
      end
      
      def next_page
        current_page + 1 if paginated? && current_page < total_pages
      end
      
      def previous
        raise NotPaginatedError unless paginated?
        all page: previous_page if previous_page
      end
      
      def next
        raise NotPaginatedError unless paginated?
        all page: next_page if next_page
      end
      
      private
      
      def pagination
        response['pagination']
      end
    end
  end
end