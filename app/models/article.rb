class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  include Mongoid::CounterCache

  # Atrributes
  # :title              标题
  # :description        描述
  # :content            内容
  # :url                链接地址

  # Fields
  field :title,           type: String
  field :description,     type: String
  field :content,         type: String
  field :url,             type: String

  # Uploaders
  uploader :cover, ImageUploader
  
  # CounterCache
  counter_cache :article_group

  # Relations
  belongs_to :article_group
  
  # Validates
  validates :title, :description, presence: true
  validates :content, presence: true, unless: ->(m) { !m.url.blank? }
  validates :title, length: { within: 2..50 }, unless: ->(m) { m.title.blank? }
  validates :description, length: { within: 2..100 }, unless: ->(m) { m.description.blank? }
  validates :content, length: { within: 2..5000 }, unless: ->(m) { m.content.blank? }
end
