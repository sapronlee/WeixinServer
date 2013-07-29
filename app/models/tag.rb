class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :name       名称
  # :level      等级

  # Fields
  field :name,  type: String
  field :level, type: Integer

  has_and_belongs_to_many :replies
end
