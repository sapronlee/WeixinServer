class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache

  attr_readonly :identifier
  attr_accessible :name, :en_name, :desc, :user_id

  # Attributes
  # :name                         名称
  # :en_name                      微信号
  # :token                私有 Token（供客户端使用）
  # :lock                         锁定（供客户端使用）
  # :identifier                   标识符（由微信返回）
  # :desc                         功能介绍

  # Fields
  field :name,          type: String
  field :en_name,       type: String
  field :token,         type: String
  field :identifier,    type: String
  field :desc,          type: String

  # Relations
  has_many :members
  belongs_to :user, autosave: true

  # Callbacks
  before_create :build_token

  validates :name, :en_name, presence: true, uniqueness: true
  validates :user_id, presence:true, uniqueness: true

  # Methods
  def update_identifier identifier
    self.set(:identifier, identifier) if self.identifier.blank?
  end

  private
  def build_token
    self.token = "#{SecureRandom.hex(10)}:#{self.id}" if self.token.blank?
  end
end