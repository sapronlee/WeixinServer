class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :fans_id       关注者id

  # Fields
  field :fans_id, type: String

  has_many :messages
  has_many :replys
  belongs_to :account

end
