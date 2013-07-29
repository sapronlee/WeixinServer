class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :open_id       关注者id

  # Fields
  field :open_id, type: String

  belongs_to :account

end
