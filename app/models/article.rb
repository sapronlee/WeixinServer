class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  # Atrributes
  # :picture
  # :desc
  # :content

  # Fields
  field :desc,    type: String
  field :content, type: String
  field :order,   type: Integer

  # Uploaders
  uploader :cover, ImageUploader

  # Relations
  belongs_to :article_group
end
