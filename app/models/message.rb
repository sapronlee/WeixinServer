class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache

  # Attributes
  # :msg_type        类型
  # :content         内容

  # Fields
  field :content,         type: String
  field :msg_type,        type: String
  
  # CounterCache
  counter_cache :member

  #Relations
  belongs_to :member

end
