class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  attr_accessible :name, :en_name, :desc, :avatar, :qr_code

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :token                        微信API Token
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

  #Validates
  validate :create_amount, on: :create

  has_many :members
  belongs_to :company

  before_create :generate_token_and_identifier

  private
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

  def create_amount
    if self.company.accounts.count >= self.company.weixin_count
      errors.add(:company, "can't create new account.")
    end
  end

end