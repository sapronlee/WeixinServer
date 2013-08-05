module Mongoid
  module DataTable
    extend ActiveSupport::Concern
    module ClassMethods
      def ng_table(params = {})
        NgTable.new(params, self).objects
      end
      
      class NgTable
        def initialize(params, klass)
          @klass = klass
          @page = params[:page]
          @page_size = params[:count]
          @filter = params[:filter]
          @sort = params[:sorting]
        end
        
        def total_count
          objects.total_count
        end
        
        def objects
          @objects ||= fetch_objects
        end
        
        private
        def fetch_objects
          objects = @filter.present? ? @klass.and(query_filter) : @klass
          objects = @sort.present? ? objects.order_by(query_sort) : objects
          objects = objects.page(@page).per(@page_size)
          objects
        end
        
        def query_filter
          result = []
          @filter.map { |k, v| result << Hash[k.to_s.underscore.to_sym, Regexp.new(".*#{URI.decode(v)}.*")] }
          result
        end
        
        def query_sort
          @sort.map { |k, v| "#{k} #{v.upcase}" }.first
        end
        
      end
      
    end
  end
end