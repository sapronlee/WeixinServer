class AdminUser
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :captcha
  attr_accessible :email, :realname, :password, :password_confirmation, :remember_me, :captcha

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  field :realname,               type: String, default: ""
  field :email,                  type: String, default: ""
  field :encrypted_password,     type: String, default: ""
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at,    type: Time
  field :sign_in_count,          type: Integer, default: 0
  field :current_sign_in_at,     type: Time
  field :last_sign_in_at,        type: Time
  field :current_sign_in_ip,     type: String
  field :last_sign_in_ip,        type: String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
end
