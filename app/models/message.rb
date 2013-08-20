class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid
  include Mongoid::DataTable
  include Mongoid::CounterCache

  # Attributes
  # :msg_type        类型
  # :content         内容

  # Fields
  field :content,         type: String
  field :msg_type,        type: String

  # SimpleEnums
  as_enum :msg_type, { text: 0, image: 1, location: 2, link: 3, event: 4 }, field: { type: Integer, default: 0 }
  
  # CounterCache
  counter_cache :member

  #Relations
  belongs_to :member

end
