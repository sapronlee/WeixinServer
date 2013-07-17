# encoding: utf-8

class CoverUploader < ImageUploader
  
  version :small do
    process :resize_to_fill => [300, 200]
  end
  
  version :mobile do
    process :resize_to_fill => [600, 400]
  end

end
