class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :captcha

  attr_accessible :email, :realname, :password, :password_confirmation, :remember_me, :captcha

  # Fields
  # :realname                     真实姓名
  # :encrypted_password           加密密码
  # :reset_password_token         重置密码票据
  # :reset_password_sent_at       发送重置密码时间
  # :remember_created_at          记住我的创建时间
  # :sign_in_count                登录总数
  # :current_sign_in_at           当前登录时间
  # :last_sign_in_at              最后登录时间
  # :current_sign_in_ip           当前登录IP
  # :last_sign_in_ip              最后登录IP
  # :avatar                       头像
  field :realname,                type: String, default: ''
  field :email,                   type: String, default: ''
  field :encrypted_password,      type: String, default: ''
  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time
  field :remember_created_at,     type: Time
  field :sign_in_count,           type: Integer, default: 0
  field :current_sign_in_at,      type: Time
  field :last_sign_in_at,         type: Time
  field :current_sign_in_ip,      type: String
  field :last_sign_in_ip,         type: String

  # Devices
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Uploaders
  # uploader :avatar, AvatarUploader, presence: false

  # Scopes

  # Validates
  validates :realname, presence: true
  validates :realname, length: { within: 2..20 }, unless: ->(m) { m.realname.blank? }
  validates :email, presence: true

  # Relations
  has_one :account, dependent: :destroy

end
