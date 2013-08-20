class ArticleGroup
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :name             别名（方便记忆）
  # :articles_count   文章个数

  # Fields
  field :name,           type: String
  field :articles_count, type: Integer, default: 0

  # Relations
  has_many :articles, dependent: :destroy

  # Validates
  validates :name, length: { within: 2..20 }, unless: ->(m) { m.name.blank? }
end
