class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :msg_type        类型
  # :content         内容
  # :msg_id          消息id

  # Fields
  field :content,         type: String
  field :msg_type,        type: String

  #Relations
  belongs_to :member

end
