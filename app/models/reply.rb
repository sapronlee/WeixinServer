class Reply
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  # Attributes
  # :number      查询编码
  # :name         名称
  # :title        标题
  # :content      内容[text]
  # :location     位置
  # :msg_type     类型

  # Fields
  field :number,    type: String
  field :name,      type: String
  field :title,     type: String
  field :content,   type: String
  field :location,  type: Point
  field :tags,      type: Array

  # SimpleEnums
  as_enum :msg_type, { text: 0, article: 1, audio: 2 }, field: { type: Integer, default: 0 }

  # Relations
  belongs_to  :area
  has_one     :article
  has_one     :audio
  has_and_belongs_to_many :tags
  
end
