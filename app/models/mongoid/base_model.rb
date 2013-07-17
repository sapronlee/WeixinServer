# encoding: utf-8

module Mongoid
  module BaseModel
    
    extend ActiveSupport::Concern
    
    included do
      scope :recent, desc(:_id)
      scope :exclude_ids, Proc.new { |ids| where(:_id.nin => ids.map(&:to_i)) }
    end

    module ClassMethods
     
      def find_by_id(id)
        if id.is_a?(Integer) or id.is_a?(String)
          where(:_id => id.to_i).first
        else
          nil
        end
      end
    
      def find_in_batches(opts = {})
        batch_size = opts[:batch_size] || 1000
        start = opts.delete(:start).to_i || 0
        objects = self.limit(batch_size).skip(start)
        t = Time.new
        while objects.any?
          yield objects
          start += batch_size
          break if objects.size < batch_size
          objects = self.limit(batch_size).skip(start)
        end
      end
      
    end
    
  end
end