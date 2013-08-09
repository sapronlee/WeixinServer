class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid
  include Mongoid::DataTable

  # Attributes
  # :msg_type        类型
  # :content         内容
  # :msg_id          消息id

  # Fields
  field :content,         type: String


  # SimpleEnums
  as_enum :msg_type, { text: 0, image: 1, location: 2, link: 3, event: 4 }, field: { type: Integer, default: 0 }

  #Relations
  belongs_to :member

end
