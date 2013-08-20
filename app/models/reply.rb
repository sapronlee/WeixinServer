class Reply
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::DataTable
  include SimpleEnum::Mongoid

  # Attributes
  # :number      查询编码
  # :name         名称（列表菜单使用）
  # :content      内容[text]
  # :location     位置
  # :msg_type     类型

  # Fields
  field :number,    type: String
  field :name,      type: String
  field :content,   type: String
  field :location,  type: Point
  field :tags,      type: Array

  # SimpleEnums
  as_enum :msg_type, { text: 0, news: 1, music: 2 }, field: { type: Integer, default: 0 }

  # Relations
  has_many    :articles
  has_one     :audio
  has_and_belongs_to_many :tags
  belongs_to  :account
  
end
