class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :keyword      查询编码
  # :name         名称
  # :title        标题
  # :content      内容[text]
  # :location     位置
  # :msg_type     类型

  # Fields
  field :keyword, type: String
  field :name,    type: String
  field :title,   type: String
  field :content, type: String
  field :location type: String

  # SimpleEnums
  as_enum :msg_type, { text: 0, article: 1, audio: 2 }, field: { type: Integer, default: 0 }

  # Relations
  has_one :article
  has_one :audio
  has_and_belongs_to_many :tags
end
