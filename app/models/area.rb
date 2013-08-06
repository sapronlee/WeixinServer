class Area
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::DataTable

  # Attributes
  # :name      名称

  # Fields
  field :name, type: String

  # Relations
  has_one   :accounts
  has_many  :reply

  # Validates
  validates :name, presence: true, uniqueness: true

end