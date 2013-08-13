class Audio
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  # Attributes
  # :file         文件
  # :title        标题
  # :description  描述

  # Fields
  field :title,       type: String
  field :description, type: String

  # Uploader
  uploader_media :file, AudioUploader, size: Setting.audio_upload_size, presence: false

end
