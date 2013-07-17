require 'carrierwave/media'
# encoding: utf-8

class AudioUploader < BaseUploader
  include CarrierWave::Media

  process :media_info

  def move_to_store
    true
  end

  def extension_white_list
    WebConfig.upload_audio_extension
  end

  def store_dir
    "resources/audios/#{model.class.to_s.pluralize.underscore}/#{mounted_as.to_s.pluralize.underscore}"
  end

end
