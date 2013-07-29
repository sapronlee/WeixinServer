class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  # Atrributes
  # :picture
  # :desc
  # :content

  # Fields
  field :desc,    type: String
  field :content, type: String

  # Uploaders
  uploader :picture, ImageUploader

  # Relations
  belongs_to :reply
end
