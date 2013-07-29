class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  # Attributes
  # :file      文件

  # Uploaders
  uploader :file, ImageUploader

end
