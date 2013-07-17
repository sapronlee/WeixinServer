# encoding: utf-8

class PictureUploader < ImageUploader
  
  version :thumb do
    process resize_to_fit: WebConfig.thumb_image_dimensions
  end

end
