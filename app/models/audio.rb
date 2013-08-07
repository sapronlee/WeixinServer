class Audio
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  # Attributes
  # :desc       描述
  # :file       文件

  # Fields
  field :desc, type: String

  # Uploader
  uploader_media :file, AudioUploader, size: Setting.audio_upload_size

end
