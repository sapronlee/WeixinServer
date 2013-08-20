class ArticleGroup
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  # Validates
  validates :name, presence: true

  # Relations
  belongs_to :reply
  has_many :articles, dependent: :destroy

  accepts_nested_attributes_for :articles, reject_if: lambda { |a| a[:file].blank? }, allow_destroy: true
end
