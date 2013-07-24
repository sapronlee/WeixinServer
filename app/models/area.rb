class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :name      名称

  # Fields
  field :name, type: String

  # Relations
  has_many :accounts

end