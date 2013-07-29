class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :name      名称

  # Fields
  field :name, type: String

  # Relations
  has_one   :accounts
  has_many  :reply

end