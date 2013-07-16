# encoding : utf-8

Devise.setup do |config|
  
  # ==> Mailer Configuration
  config.mailer_sender = "sapronlee@gmail.com"
  # config.mailer = "Devise::Mailer"

  # ==> ORM configuration
  require 'devise/orm/mongoid'

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]

  # ==> Configuration for :database_authenticatable
  config.stretches = Rails.env.test? ? 1 : 10

  # ==> Configuration for :confirmable
  config.reconfirmable = true

  # ==> Configuration for :rememberable
  config.remember_for = 1.weeks

  # ==> Configuration for :validatable
  config.password_length = 6..128

  # ==> Configuration for :timeoutable
  config.timeout_in = 60.minutes

  # ==> Configuration for :lockable
  # config.lock_strategy = :failed_attempts
  # config.unlock_keys = [ :email ]

  # ==> Configuration for :recoverable
  config.reset_password_within = 6.hours

  # ==> Configuration for :encryptable
  # config.encryptor = :sha512

  # ==> Configuration for :token_authenticatable

  # ==> Scopes configuration
  config.scoped_views = true

  # ==> Navigation configuration
  config.sign_out_via = :delete

  # ==> OmniAuth

  # ==> Warden configuration

  # ==> Mountable engine configurations

end
