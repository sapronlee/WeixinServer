class ArticleCover
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  
  # Attributes
  # :file      文件

  # Uploaders
  uploader :file, ArticleCoverUploader, size: Setting.image_upload_size
  
  # Relations
  belongs_to :article
  
end
