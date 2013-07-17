class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  #
  # :ToUserName     开发者微信号
  # :FromUserName   发送方帐号
  # :CreateTime     消息创建时间
  # :MsgType        类型
  # :Content        内容
  # :MsgId          消息id

  # Fields
  field :to_user_name,    type: String
  field :from_user_name,  type: String
  field :create_time,     type: Integer
  field :Content,         type: String
  field :msg_type,        type: String

  belongs_to member

end
