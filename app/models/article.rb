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

  # Uploaders
  uploader :cover, ImageUploader

  # Relations
  belongs_to :reply
end
