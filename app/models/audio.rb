class Audio
  include Mongoid::Document
  include Mongoid::Timestamps

  # Attributes
  # :desc       描述
  # :file       文件

  # Fields
  field :desc, type: String

  # Uploader
  uploader_media :file, AudioUploader, size: Setting.audio_upload_size

end
