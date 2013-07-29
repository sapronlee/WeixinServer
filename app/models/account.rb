class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  include Mongoid::CounterCache

  attr_accessible :name, :en_name, :desc, :avatar, :qr_code

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :private_token                私有 Token（供客户端使用）
  # :lock                         锁定（供客户端使用）
  # :identifier                   标识符（由微信返回）
  # :desc                         功能介绍
  # :avatar                       头像
  # :qr_code                      二维码（由微信生成）

  # Fields
  field :name,          type: String
  field :en_name,       type: String
  field :private_token, type: String
  field :lock,          type: Boolean, default: true
  field :identifier,    type: String
  field :desc,          type: String

  # Uploaders
  uploader :avatar,   WeiXinAvatarUploader
  uploader :qr_code,  WeiXinQrCodeUploader

  # Relations
  has_many :members
  belongs_to :area

  # Callbacks
  before_create :build_private_token

  validates :name, :en_name, presence: true, uniqueness: true

  # Methods
  def update_identifier identifier
    self.set(:identifier, identifier) if self.identifier.blank?
  end
  
  private
  def build_private_token
    self.private_token = "#{SecureRandom.hex(10)}:#{self.id}" if self.private_token.blank?
  end
end