class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache

  # Atrributes
  # :title              标题
  # :description        描述
  # :content            内容
  # :master             顶层文章
  # :url                链接地址

  # Fields
  field :title,           type: String
  field :description,     type: String
  field :content,         type: String
  field :url,             type: String
  field :master,          type: Boolean, default: false
  field :order,           type: Integer, default: 0
  
  # CounterCache
  counter_cache :article_group

  # Relations
  belongs_to :article_group
  has_one    :article_cover, dependent: :destroy
  
  # Nested Attributes
  accepts_nested_attributes_for :article_cover, allow_destroy: true
  
  # Validates
  validates :title, :description, presence: true
  validates :content, presence: true, unless: ->(m) { !m.url.blank? }
  validates :title, length: { within: 2..50 }, unless: ->(m) { m.title.blank? }
  validates :description, length: { within: 2..100 }, unless: ->(m) { m.description.blank? }
  validates :content, length: { within: 2..5000 }, unless: ->(m) { m.content.blank? }
  
  # Callbacks
  before_create :create_new_group, :find_article_cover
  after_create :destroy_group
  
  # Methods
  def create_new_group
    self.article_group = ArticleGroup.create! if self.article_group_id.blank?
  end
  
  def find_article_cover
    self.article_cover = ArticleCover.find self.article_cover_id if self.article_cover_id.present?
  end
  
  def destroy_group
    self.article_group.destroy if self.errors.any? && self.article_group.articles_count == 1
  end
end
