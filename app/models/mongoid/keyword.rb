module Mongoid
  module Keyword
    extend ActiveSupport::Concern
    included do
      field :slug, type: String
    end
  end
end