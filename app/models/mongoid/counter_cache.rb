module Mongoid
  module CounterCache
    
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      # @overload counter_cache(clazz, options = {})
      #   @param [clazz] 指定belongs_to的一端
      #   @param [Hash] options
      #   @param options [String or Symbol] :field 自定义存储字段名称.
      #
      # @example A custom builder
      #   class Forum
      #     include Mongoid::Document
      #     include Mongoid::UploadImage
      #
      #     field :posts_count, type: Integer, default: 0
      #
      #     has_many :posts
      #   end
      #   
      #   class Post
      #     include Mongoid::CounterCache
      #     
      #     belongs_to :forum
      #     counter_cache :forum
      #   end
      #
      #   forum.posts_count => 1
      #
      def counter_cache clazz, options = {}
        if options[:field]
          counter_name = "#{options[:field].to_s}"
        else
          counter_name = "#{model_name.demodulize.pluralize.underscore}_count"
        end
        
        set_callback(:create, :after) do |record|
          relation = record.send clazz
          relation.inc(counter_name.to_sym, 1) if relation && relation.class.fields.keys.include?(counter_name)
        end
        
        set_callback(:destroy, :after) do |record|
          relation = record.send clazz
          relation.inc(counter_name.to_sym, -1) if relation && relation.class.fields.keys.include?(counter_name)
        end
        
      end
    end # => ClassMethods
  end # => CounterCache
end # => Mongoid