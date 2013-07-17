# encoding: utf-8

class WeiXinAvatarUploader < ImageUploader

  process :resize_to_fit => [258, 258]
  
  version :mini do
    process :resize_to_fill => [43, 43]
  end

end
