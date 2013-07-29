class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  # Attributes
  # :create_time     消息创建时间
  # :msg_type        类型
  # :content         内容
  # :msg_id          消息id

  # Fields
  field :create_time,     type: Integer
  field :content,         type: String
  field :msg_type,        type: String

  #Relations
  belongs_to :member

end
