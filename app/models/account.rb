class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  include Mongoid::CounterCache

  attr_accessible :name, :en_name, :desc, :avatar, :qr_code

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :token                        API访问 Token
  # :identifier                   标识符（由微信返回）
  # :desc                         功能介绍
  # :avatar                       头像
  # :qr_code                      二维码（由微信生成）

  # Fields
  field :name,        type: String
  field :en_name,     type: String
  field :token,       type: String
  field :identifier,  type: String
  field :desc,        type: String

  # Uploaders
  uploader :avatar,   WeiXinAvatarUploader
  uploader :qr_code,  WeiXinQrCodeUploader
  
  # CounterCache
  counter_cache :company

  # Relations
  has_many :members

  # Callbacks
  before_create :generate_token_and_identifier

  # Methods
  private
  

end