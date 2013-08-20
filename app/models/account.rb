class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :name, :en_name, :desc

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :token                        Token
  # :identifier                   标识符（由微信返回）
  # :desc                         功能介绍

  # Fields
  field :name,            type: String
  field :en_name,         type: String
  field :token,           type: String
  field :identifier,      type: String
  field :desc,            type: String
  field :members_count,   type: Integer, default: 0
  field :replies_count,   type: Integer, default: 0
  field :audios_count,    type: Integer, default: 0

  # Relations
  has_many :members
  has_many :audios
  belongs_to :user

  # Callbacks
  before_create :build_token

  validates :name, :en_name, presence: true, uniqueness: true

  # Methods
  def update_identifier identifier
    self.set(:identifier, identifier) if self.identifier.blank?
  end
  
  private
  def build_token
    self.token = "#{SecureRandom.hex(15)}" if self.token.blank?
  end
end