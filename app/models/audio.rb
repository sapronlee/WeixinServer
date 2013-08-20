class Audio
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Uploader
  include Mongoid::CounterCache
  include Mongoid::DataTable

  # Attributes
  # :file         文件
  # :title        标题
  # :description  描述

  # Fields
  field :title,       type: String
  field :description, type: String
  
  # CounterCache
  counter_cache :account

  # Uploader
  uploader_media :file, AudioUploader, size: Setting.audio_upload_size, presence: false
  
  # Relations
  belongs_to :account

  # Validates
  validates :title, presence: true

end
