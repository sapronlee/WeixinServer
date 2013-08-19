class Audio
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader

  # Attributes
  field :title, type: String
  field :desc,  type: String

  # Uploader
  uploader_media :file, AudioUploader, size: Setting.audio_upload_size

  # Validates
  validates :title, presence: true

end
