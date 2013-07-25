class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  include Mongoid::CounterCache

  attr_accessible :name, :en_name, :desc, :avatar, :qr_code

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :token                        API访问 Token（供微信使用）
  # :private_token                私有 Token（供客户端使用）
  # :lock                         锁定（供客户端使用）
  # :identifier                   标识符（由微信返回）
  # :desc                         功能介绍
  # :avatar                       头像
  # :qr_code                      二维码（由微信生成）

  # Fields
  field :name,          type: String
  field :en_name,       type: String
  field :token,         type: String
  field :lock,          type: Boolean, default: true
  field :private_token, type: String
  field :identifier,    type: String
  field :desc,          type: String

  # Uploaders
  uploader :avatar,   WeiXinAvatarUploader
  uploader :qr_code,  WeiXinQrCodeUploader

  # Relations
  has_many :members
  belongs_to :area

  # Callbacks
  before_create :build_private_token, :generate_token_and_identifier

  # Methods
  private
  def build_private_token
    self.private_token = "#{SecureRandom.hex(10)}:#{self.id}" if self.private_token.blank?
  end

  def generate_token_and_identifier
    if en_name.present?
      self.token = build_token
      self.identifier = build_identifier
    end
  end

  def build_token
    en_name
  end

  def build_identifier
    en_name
  end
end