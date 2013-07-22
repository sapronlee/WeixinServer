class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :name           企业名称
  # :weixin_count   可绑定帐号
  # :identifier     企业标识

  # Fields
  field :name,          type: String
  field :weixin_count,  type: Integer, default: 1
  field :identifier,    type: String

  before_create :generate_key, on: :create

  has_many :accounts

  private
  def generate_key
    self.identifier = Digest::MD5.hexdigest(Time.now.to_s + rand(1..1000).to_s)
  end
end