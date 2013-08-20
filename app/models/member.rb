class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache

  # Attributes
  # :open_id       关注者id

  # Fields
  field :open_id,         type: String
  field :messages_count,  type: Integer, default: 0
  
  # CounterCache
  counter_cache :account

  belongs_to :account

end
